import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_19/database/preference_handler.dart';
import 'package:ppkd_b6/tugas14/models/got_books.dart';
import 'package:ppkd_b6/tugas14/models/got_character.dart';
import 'package:ppkd_b6/tugas14/models/got_houses.dart';
import 'package:ppkd_b6/tugas14/services/api_services.dart';
import 'package:ppkd_b6/tugas14/services/dio_client.dart';
import 'package:ppkd_b6/tugas14/tugas14_login_screen.dart';

class Tugas14Screen extends StatefulWidget {
  const Tugas14Screen({super.key});

  @override
  State<Tugas14Screen> createState() => _Tugas14ScreenState();
}

class _Tugas14ScreenState extends State<Tugas14Screen> {
  late final ApiService _apiService;
  late Future<List<GotCharacter>> _charactersFuture;
  late Future<List<GotBooks>> _booksFuture;
  late Future<List<GotHouses>> _housesFuture;

  int _currentIndex = 0;

  List<GotCharacter> _allCharacters = [];
  List<GotCharacter> _filteredCharacters = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedHouse = 'All';

  // Popular GOT Houses for quick filtering
  final List<String> _houses = [
    'All',
    'Stark',
    'Lannister',
    'Targaryen',
    'Baratheon',
    'Greyjoy',
    'Tyrell',
  ];

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    _charactersFuture = _apiService.getCharacters().then((value) {
      setState(() {
        _allCharacters = value;
        _filteredCharacters = value;
      });
      return value;
    });
    _booksFuture = _apiService.getBooks();
    _housesFuture = _apiService.getHouses();
  }

  void _onSearchChanged() {
    _filterCharacters();
  }

  void _filterCharacters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCharacters = _allCharacters.where((char) {
        final matchesQuery =
            (char.fullName?.toLowerCase().contains(query) ?? false) ||
            (char.title?.toLowerCase().contains(query) ?? false) ||
            (char.family?.toLowerCase().contains(query) ?? false);

        final matchesHouse =
            _selectedHouse == 'All' ||
            (char.family?.toLowerCase().contains(
                  _selectedHouse.toLowerCase(),
                ) ??
                false);

        return matchesQuery && matchesHouse;
      }).toList();
    });
  }

  void _selectHouse(String house) {
    setState(() {
      _selectedHouse = house;
    });
    _filterCharacters();
  }

  Widget _buildCharactersTab(
    BuildContext context,
    Color themeBg,
    Color cardBg,
    Color accentGold,
    Color textWhite,
    Color textGrey,
  ) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search characters, titles...',
              hintStyle: TextStyle(color: textGrey),
              prefixIcon: Icon(Icons.search, color: accentGold),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: accentGold),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              filled: true,
              fillColor: cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: accentGold.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: accentGold, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: accentGold.withValues(alpha: 0.3),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            style: TextStyle(color: textWhite),
          ),
        ),

        // Quick Filter Houses
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _houses.length,
            itemBuilder: (context, index) {
              final house = _houses[index];
              final isSelected = _selectedHouse == house;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(house),
                  selected: isSelected,
                  onSelected: (_) => _selectHouse(house),
                  selectedColor: accentGold.withValues(alpha: 0.2),
                  checkmarkColor: accentGold,
                  side: BorderSide(
                    color: isSelected
                        ? accentGold
                        : accentGold.withValues(alpha: 0.2),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? accentGold : textWhite,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  backgroundColor: cardBg,
                ),
              );
            },
          ),
        ),

        // Character List
        Expanded(
          child: FutureBuilder<List<GotCharacter>>(
            future: _charactersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: accentGold),
                      const SizedBox(height: 16),
                      Text(
                        'Summoning Archives...',
                        style: TextStyle(
                          color: textGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          size: 64,
                          color: accentGold.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The Raven failed to return with details.',
                          style: TextStyle(
                            color: textWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check your connection or API status.\n${snapshot.error}',
                          style: TextStyle(color: textGrey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _loadData();
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentGold,
                            foregroundColor: themeBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (_filteredCharacters.isEmpty) {
                return Center(
                  child: Text(
                    'No characters found in the scrolls.',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  _loadData();
                },
                color: accentGold,
                backgroundColor: cardBg,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final char = _filteredCharacters[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: accentGold.withValues(alpha: 0.15),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GotCharacterDetailScreen(character: char),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: accentGold.withValues(alpha: 0.3),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:
                                    char.imageUrl != null &&
                                        char.imageUrl!.isNotEmpty
                                    ? Image.network(
                                        char.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                color: themeBg,
                                                child: Icon(
                                                  Icons.person,
                                                  color: accentGold.withValues(
                                                    alpha: 0.5,
                                                  ),
                                                ),
                                              );
                                            },
                                      )
                                    : Container(
                                        color: themeBg,
                                        child: Icon(
                                          Icons.person,
                                          color: accentGold.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      char.fullName ?? 'Unknown Name',
                                      style: TextStyle(
                                        fontFamily: 'Georgia',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: textWhite,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      char.title ?? 'No Title',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: accentGold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      char.family ?? 'Unknown House',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: accentGold),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBooksTab(
    BuildContext context,
    Color themeBg,
    Color cardBg,
    Color accentGold,
    Color textWhite,
    Color textGrey,
  ) {
    return FutureBuilder<List<GotBooks>>(
      future: _booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: accentGold));
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Error loading books:\n${snapshot.error}',
                style: TextStyle(color: textWhite),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final books = snapshot.data ?? [];
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            final releasedYear = book.released.year;
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: accentGold.withValues(alpha: 0.2)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: accentGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: accentGold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(Icons.book, color: accentGold, size: 30),
                ),
                title: Text(
                  book.name,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textWhite,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'By ${book.authors.join(", ")}',
                      style: TextStyle(
                        color: accentGold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.pages, size: 16, color: textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '${book.numberOfPages} pages',
                          style: TextStyle(color: textGrey),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.calendar_today, size: 16, color: textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '$releasedYear',
                          style: TextStyle(color: textGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  _showBookDetail(
                    context,
                    book,
                    accentGold,
                    cardBg,
                    textWhite,
                    textGrey,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showBookDetail(
    BuildContext context,
    GotBooks book,
    Color accentGold,
    Color cardBg,
    Color textWhite,
    Color textGrey,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: textGrey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  book.name,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textWhite,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ISBN: ${book.isbn}',
                  style: TextStyle(color: textGrey, fontSize: 12),
                ),
                const Divider(color: Colors.white10, height: 24),
                _buildInfoRow(
                  'Author(s)',
                  book.authors.join(", "),
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Publisher',
                  book.publisher,
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Pages',
                  '${book.numberOfPages}',
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Released',
                  book.released.toIso8601String().substring(0, 10),
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Characters',
                  '${book.characters.length}',
                  accentGold,
                  textWhite,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    Color accentGold,
    Color textWhite,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF8A8F9E), fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textWhite,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHousesTab(
    BuildContext context,
    Color themeBg,
    Color cardBg,
    Color accentGold,
    Color textWhite,
    Color textGrey,
  ) {
    return FutureBuilder<List<GotHouses>>(
      future: _housesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: accentGold));
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Error loading houses:\n${snapshot.error}',
                style: TextStyle(color: textWhite),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final houses = snapshot.data ?? [];
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: houses.length,
          itemBuilder: (context, index) {
            final house = houses[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: accentGold.withValues(alpha: 0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            house.name,
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textWhite,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: accentGold.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: accentGold.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            house.region,
                            style: TextStyle(color: accentGold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    if (house.words.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        '"${house.words}"',
                        style: TextStyle(
                          color: accentGold,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      'Coat of Arms: ${house.coatOfArms.isNotEmpty ? house.coatOfArms : "None"}',
                      style: TextStyle(color: textGrey, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(color: Colors.white10, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Founded: ${house.founded ?? "Unknown"}',
                          style: TextStyle(color: textGrey, fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            _showHouseDetail(
                              context,
                              house,
                              accentGold,
                              cardBg,
                              textWhite,
                              textGrey,
                            );
                          },
                          child: Text(
                            'Show Details',
                            style: TextStyle(
                              color: accentGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showHouseDetail(
    BuildContext context,
    GotHouses house,
    Color accentGold,
    Color cardBg,
    Color textWhite,
    Color textGrey,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: textGrey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  house.name,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textWhite,
                  ),
                ),
                if (house.words.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '"${house.words}"',
                    style: TextStyle(
                      color: accentGold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                ],
                const Divider(color: Colors.white10, height: 24),
                _buildInfoRow('Region', house.region, accentGold, textWhite),
                _buildInfoRow(
                  'Coat of Arms',
                  house.coatOfArms.isNotEmpty ? house.coatOfArms : "-",
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Current Lord',
                  house.currentLord.isNotEmpty ? "Yes" : "-",
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Founder',
                  house.founder.isNotEmpty ? "Yes" : "-",
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Died Out',
                  house.diedOut.isNotEmpty ? house.diedOut : "No",
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Titles Count',
                  '${house.titles.length}',
                  accentGold,
                  textWhite,
                ),
                _buildInfoRow(
                  'Seats Count',
                  '${house.seats.length}',
                  accentGold,
                  textWhite,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Custom dark theme for GOT feel
    final themeBg = const Color(0xFF0F111A);
    final cardBg = const Color(0xFF1E2230);
    final accentGold = const Color(0xFFE5A93C);
    final textWhite = const Color(0xFFF5F6FA);
    final textGrey = const Color(0xFF8A8F9E);

    Widget activeTabBody;
    switch (_currentIndex) {
      case 0:
        activeTabBody = _buildCharactersTab(
          context,
          themeBg,
          cardBg,
          accentGold,
          textWhite,
          textGrey,
        );
        break;
      case 1:
        activeTabBody = _buildBooksTab(
          context,
          themeBg,
          cardBg,
          accentGold,
          textWhite,
          textGrey,
        );
        break;
      case 2:
        activeTabBody = _buildHousesTab(
          context,
          themeBg,
          cardBg,
          accentGold,
          textWhite,
          textGrey,
        );
        break;
      default:
        activeTabBody = _buildCharactersTab(
          context,
          themeBg,
          cardBg,
          accentGold,
          textWhite,
          textGrey,
        );
    }

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: themeBg,
        cardColor: cardBg,
        colorScheme: ColorScheme.dark(primary: accentGold, surface: cardBg),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _currentIndex == 0
                ? 'GoT Chronicles'
                : _currentIndex == 1
                ? 'GoT Library'
                : 'GoT Great Houses',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              color: accentGold,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: themeBg,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: accentGold),
              tooltip: 'Logout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      backgroundColor: cardBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: accentGold, width: 1.5),
                      ),
                      title: Text(
                        'Abandon the Wall?',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          color: accentGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to log out and abandon the archives?',
                        style: TextStyle(color: textWhite),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: textGrey),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentGold,
                            foregroundColor: themeBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(dialogContext).pop();
                            await PreferenceHandler.logOut();
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Tugas14LoginScreen(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: accentGold.withValues(alpha: 0.3),
              height: 1.0,
            ),
          ),
        ),
        body: SafeArea(child: activeTabBody),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: cardBg,
          selectedItemColor: accentGold,
          unselectedItemColor: textGrey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Characters',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
            BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Houses'),
          ],
        ),
      ),
    );
  }
}

class GotCharacterDetailScreen extends StatelessWidget {
  final GotCharacter character;

  const GotCharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final themeBg = const Color(0xFF0F111A);
    final cardBg = const Color(0xFF1E2230);
    final accentGold = const Color(0xFFE5A93C);
    final textWhite = const Color(0xFFF5F6FA);

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: themeBg,
        cardColor: cardBg,
        colorScheme: ColorScheme.dark(primary: accentGold, surface: cardBg),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            character.fullName ?? 'Character Detail',
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: themeBg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: accentGold),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Character High-Quality Large Image Frame
              if (character.imageUrl != null)
                Center(
                  child: Container(
                    height: 300,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accentGold, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      character.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: cardBg,
                        child: Icon(Icons.person, size: 100, color: accentGold),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Title badge
              Text(
                character.fullName ?? 'Unknown',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: textWhite,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentGold.withValues(alpha: 0.5)),
                ),
                child: Text(
                  character.title ?? 'No Title',
                  style: TextStyle(
                    color: accentGold,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),

              // Details section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentGold.withValues(alpha: 0.15)),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'First Name',
                      character.firstName ?? '-',
                      accentGold,
                      textWhite,
                    ),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow(
                      'Last Name',
                      character.lastName ?? '-',
                      accentGold,
                      textWhite,
                    ),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow(
                      'House / Family',
                      character.family ?? '-',
                      accentGold,
                      textWhite,
                    ),
                    const Divider(color: Colors.white10, height: 24),
                    _buildDetailRow(
                      'ID Record',
                      '#${character.id ?? '-'}',
                      accentGold,
                      textWhite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    Color accentGold,
    Color textWhite,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8A8F9E),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: textWhite,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
