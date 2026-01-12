import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UiWidgetsPage extends StatefulWidget {
  const UiWidgetsPage({super.key});

  @override
  State<UiWidgetsPage> createState() => _UiWidgetsPageState();
}

class _UiWidgetsPageState extends State<UiWidgetsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- State Variables ---
  Set<String> _segmentedSelection = {'Day'};
  bool _isChecked = false;
  bool _isSwitched = false;
  double _sliderValue = 50;
  String? _radioGroupValue = 'Option 1';
  int _selectedIndex = 0; // For Chips
  int _navBarIndex = 0;
  int _currentStep = 0; // Pour le Stepper
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue Widgets Material 3'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.touch_app), text: 'Boutons'),
            Tab(icon: Icon(Icons.check_box), text: 'Sélection'),
            Tab(icon: Icon(Icons.text_fields), text: 'Saisie'),
            Tab(icon: Icon(Icons.notifications), text: 'Comm.'),
            Tab(icon: Icon(Icons.layers), text: 'Conteneurs'),
            Tab(icon: Icon(Icons.map), text: 'Navigation'),
            Tab(icon: Icon(Icons.info), text: 'Affichage'),
            Tab(icon: Icon(Icons.video_library), text: 'Médias'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildButtonsTab(),
          _buildSelectionTab(),
          _buildInputsTab(),
          _buildCommunicationTab(),
          _buildContainmentTab(),
          _buildNavigationTab(),
          _buildDisplayTab(),
          _buildMediaTab(),
        ],
      ),
      floatingActionButton: _tabController.index == 0 
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  // ---------------------------------------------------------------------------
  // 1. BUTTONS TAB
  // ---------------------------------------------------------------------------
  Widget _buildButtonsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Boutons Communs'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            TextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),
        const Divider(height: 30),

        _buildHeader('Icons Buttons'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            IconButton.filled(onPressed: () {}, icon: const Icon(Icons.favorite)),
            IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.favorite)),
            IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.favorite)),
          ],
        ),
        const Divider(height: 30),

        _buildHeader('Floating Action Buttons (FAB)'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.small(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            FloatingActionButton.large(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Extended FAB'),
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Segmented Button'),
        Center(
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(value: 'Day', label: Text('Jour'), icon: Icon(Icons.calendar_view_day)),
              ButtonSegment<String>(value: 'Week', label: Text('Semaine'), icon: Icon(Icons.calendar_view_week)),
              ButtonSegment<String>(value: 'Month', label: Text('Mois'), icon: Icon(Icons.calendar_month)),
            ],
            selected: _segmentedSelection,
            onSelectionChanged: (Set<String> newSelection) {
              setState(() {
                _segmentedSelection = newSelection;
              });
            },
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. SELECTION TAB
  // ---------------------------------------------------------------------------
  Widget _buildSelectionTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Contrôles Simples'),
        SwitchListTile(
          title: const Text('Switch'),
          value: _isSwitched,
          onChanged: (v) => setState(() => _isSwitched = v),
        ),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _isChecked,
          onChanged: (v) => setState(() => _isChecked = v ?? false),
        ),
        const Divider(),
        
        _buildHeader('Radio Buttons'),
        Column(
          children: ['Option 1', 'Option 2'].map((val) => RadioListTile<String>(
            title: Text(val),
            value: val,
            groupValue: _radioGroupValue,
            onChanged: (v) => setState(() => _radioGroupValue = v),
          )).toList(),
        ),
        const Divider(),

        _buildHeader('Slider'),
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          divisions: 10,
          label: _sliderValue.round().toString(),
          onChanged: (v) => setState(() => _sliderValue = v),
        ),
        const Divider(),

        _buildHeader('Chips'),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: const Text('Chip Simple')),
            InputChip(
              label: const Text('Input Chip'),
              onDeleted: () {},
              avatar: const Icon(Icons.person),
            ),
            ChoiceChip(
              label: const Text('Choice 1'),
              selected: _selectedIndex == 0,
              onSelected: (b) => setState(() => _selectedIndex = 0),
            ),
            ChoiceChip(
              label: const Text('Choice 2'),
              selected: _selectedIndex == 1,
              onSelected: (b) => setState(() => _selectedIndex = 1),
            ),
            FilterChip(
              label: const Text('Filter me'),
              selected: true,
              onSelected: (b) {},
            ),
            ActionChip(
              avatar: const Icon(Icons.access_time),
              label: const Text('Action'),
              onPressed: () {},
            ),
          ],
        ),
        const Divider(),

        _buildHeader('Menus & Pickers'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.date_range),
              label: const Text('Date Picker'),
              onPressed: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.access_time),
              label: const Text('Time Picker'),
              onPressed: () => showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: DropdownMenu<String>(
            initialSelection: 'Menu',
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'One', label: 'Item Un'),
              DropdownMenuEntry(value: 'Two', label: 'Item Deux'),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. INPUTS TAB (Nouvel onglet)
  // ---------------------------------------------------------------------------
  Widget _buildInputsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Champs de Texte (TextField)'),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Standard',
            hintText: 'Entrez du texte...',
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Outlined',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Filled',
            filled: true,
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.visibility),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Erreur',
            errorText: 'Valeur incorrecte',
            border: const OutlineInputBorder(),
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Search Bar'),
        SearchBar(
          hintText: 'Rechercher...',
          leading: const Icon(Icons.search),
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        const Divider(height: 30),
        
        _buildHeader('Formulaire Multiligne'),
        const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. COMMUNICATION TAB
  // ---------------------------------------------------------------------------
  Widget _buildCommunicationTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Badges'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Badge(label: const Text('3'), child: const Icon(Icons.mail, size: 40)),
            Badge(child: const Icon(Icons.notifications, size: 40)),
          ],
        ),
        const Divider(height: 30),

        _buildHeader('Progress Indicators'),
        const Text('LinearProgressIndicator'),
        const SizedBox(height: 10),
        const LinearProgressIndicator(),
        const SizedBox(height: 20),
        const Text('CircularProgressIndicator'),
        const SizedBox(height: 10),
        const Center(child: CircularProgressIndicator()),
        const Divider(height: 30),

        _buildHeader('SnackBar'),
        Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Ceci est un SnackBar!'),
                  action: SnackBarAction(label: 'UNDO', onPressed: () {}),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Afficher SnackBar'),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. CONTAINMENT TAB
  // ---------------------------------------------------------------------------
  Widget _buildContainmentTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Cards'),
        Card(
          elevation: 2,
          child: const ListTile(
            leading: Icon(Icons.album),
            title: Text('Elevated Card'),
            subtitle: Text('Une carte classique avec élévation.'),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: const ListTile(
            leading: Icon(Icons.brush),
            title: Text('Filled Card'),
            subtitle: Text('Une carte remplie avec une couleur de fond.'),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text('Outlined Card'),
            subtitle: Text('Une carte avec une bordure.'),
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Dialogs & Sheets'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('AlertDialog'),
                  content: const Text('Voulez-vous accepter cette action?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Non')),
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Oui')),
                  ],
                ),
              ),
              child: const Text('Alert Dialog'),
            ),
            ElevatedButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text('Bottom Sheet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Contenu supplémentaire ici.'),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Fermer'),
                      )
                    ],
                  ),
                ),
              ),
              child: const Text('Bottom Sheet'),
            ),
          ],
        ),
        const Divider(height: 30),

        _buildHeader('ListTile & Divider'),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text('ListTile 1'),
          trailing: Icon(Icons.arrow_forward),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.email),
          title: Text('ListTile 2'),
          trailing: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. NAVIGATION TAB
  // ---------------------------------------------------------------------------
  Widget _buildNavigationTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Composants de Navigation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildHeader('App Bar (Top)'),
              Container(
                height: 56,
                color: Theme.of(context).colorScheme.primaryContainer,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.menu, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    const SizedBox(width: 20),
                    Text('AppBar Title', style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer
                    )),
                    const Spacer(),
                    Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              _buildHeader('Navigation Bar (Bottom)'),
              NavigationBar(
                selectedIndex: _navBarIndex,
                onDestinationSelected: (i) => setState(() => _navBarIndex = i),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
                  NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
              const SizedBox(height: 20),

              _buildHeader('Navigation Drawer (Demo)'),
              ElevatedButton(
                onPressed: () {
                  // Simuler un drawer sans Scaffold global
                   showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) => Row(
                      children: [
                        NavigationDrawer(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                              child: Text('Header Drawer'),
                            ),
                            NavigationDrawerDestination(
                              icon: const Icon(Icons.inbox),
                              label: const Text('Inbox'),
                            ),
                            NavigationDrawerDestination(
                              icon: const Icon(Icons.send),
                              label: const Text('Outbox'),
                            ),
                            NavigationDrawerDestination(
                              icon: const Icon(Icons.favorite),
                              label: const Text('Favorites'),
                            ),
                          ],
                        ),
                        Expanded(child: GestureDetector(
                          onTap: () => Navigator.pop(ctx),
                          child: Container(color: Colors.transparent),
                        ))
                      ],
                    ),
                  );
                },
                child: const Text('Ouvrir Navigation Drawer Demo'),
              ),
              const SizedBox(height: 20),

              _buildHeader('Navigation Rail'),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: 0,
                      onDestinationSelected: (val) {},
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    const Expanded(
                      child: Center(
                        child: Text('Contenu principal ici...'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 7. DISPLAY TAB (Nouvel onglet)
  // ---------------------------------------------------------------------------
  Widget _buildDisplayTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Expansion Tile'),
        Card(
          child: ExpansionTile(
            title: const Text('Titre Déroulable'),
            subtitle: const Text('Cliquez pour voir plus'),
            leading: const Icon(Icons.info),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Voici le contenu caché qui apparaît lorsque vous déroulez la tuile. Très utile pour les FAQ ou les détails complexes.'),
              ),
            ],
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Stepper'),
        Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            }
          },
          steps: const [
            Step(
              title: Text('Étape 1'),
              content: Text('Contenu de l\'étape 1'),
              isActive: true,
            ),
            Step(
              title: Text('Étape 2'),
              content: Text('Contenu de l\'étape 2'),
              isActive: true,
            ),
            Step(
              title: Text('Étape 3'),
              content: Text('Validation finale'),
              isActive: true,
            ),
          ],
        ),
        const Divider(height: 30),

        _buildHeader('Data Table'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nom')),
              DataColumn(label: Text('Role')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Alice')),
                DataCell(Text('Admin')),
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('Bob')),
                DataCell(Text('User')),
              ]),
              DataRow(cells: [
                DataCell(Text('3')),
                DataCell(Text('Charlie')),
                DataCell(Text('Guest')),
              ]),
            ],
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Tooltip'),
        Center(
          child: Tooltip(
            message: 'Ceci est une info-bulle !',
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Maintenir pour Tooltip'),
            ),
          ),
        ),
        const Divider(height: 30),

        _buildHeader('Grid View (Aperçu)'),
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(6, (index) {
              return Container(
                color: Colors.primaries[index % Colors.primaries.length].shade200,
                child: Center(child: Text('Item $index')),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader('Video Player'),
        Container(
          height: 300,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: const VideoPlayerWidget(),
        ),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Vidéo Réseau'),
          subtitle: Text('Chargée depuis flutter.github.io'),
        ),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Center(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        // Controls Overlay
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
