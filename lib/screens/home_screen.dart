import 'package:flutter/material.dart';
import 'package:myapp/models/user_model.dart' as user_model;
import 'package:myapp/widgets/home_widgets/hero_action_card.dart';
import 'package:myapp/widgets/home_widgets/donor_status_card.dart';
import 'package:myapp/screens/create_request_screen.dart';
import 'package:myapp/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final user_model.UserModel _user = user_model.UserModel(
    name: 'John Doe',
    bloodGroup: 'A+',
    location: 'Dhanmondi, Dhaka',
  );

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeTab(user: _user),
      const Center(child: Text('Search Screen')),
      const CreateRequestScreen(),
      const ProfileScreen(),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, selectedIndex, child) {
        return Scaffold(
          body: screens[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) => _selectedIndex.value = index,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.request_page),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeTab extends StatelessWidget {
  final user_model.UserModel user;

  const HomeTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('Hello, ${user.name}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: theme.colorScheme.primary,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(user.location, style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeroActionCard(),
                const SizedBox(height: 16.0),
                if (user.bloodGroup != null) const DonorStatusCard(),
                const SizedBox(height: 24.0),
                Text(
                  'Recent Updates',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          color: theme.colorScheme.primary,
                        ),
                        title: const Text('Request Fulfilled'),
                        subtitle: const Text('2 hours ago'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
