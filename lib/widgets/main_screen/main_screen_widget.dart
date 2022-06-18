import 'package:flutter/material.dart';
import 'package:movie/Library/Widgets/Inherited/provider.dart';
import 'package:movie/domain/data_providers/session_data_provider.dart';
import 'package:movie/widgets/main_screen/main_screen_model.dart';
import 'package:movie/widgets/movie_list/movie_list_widget.dart';
import 'package:movie/widgets/movie_list/movie_list_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Container(
            child: ElevatedButton(
              child: const Text('Log out'),
              onPressed: () => SessionDataProvider().setSessionId(null),
            ),
          ),
          NotifierProvider(
              create: () => movieListModel,
              isManagingModel: false,
              child: const MovieListWidget()
          ),
          const Text('Serials'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Serials',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
