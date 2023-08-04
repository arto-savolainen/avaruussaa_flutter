import 'package:avaruussaa_flutter/providers/stations_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/titlebar.dart';
import '../components/footer.dart';

/// Displays a grid of available weather stations. The user can click on the
/// name of a station (Station widget) to view its activity data.
class StationsView extends ConsumerStatefulWidget {
  const StationsView({super.key});

  @override
  ConsumerState<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends ConsumerState<StationsView> {
  @override
  Widget build(BuildContext context) {
    const titleBar = TitleBar(viewId: 'stations');
    final asyncStationsData = ref.watch(asyncStationsDataProvider);  

    return asyncStationsData.when(
      data: (stationsData) {
        final stationsGridView = GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 0.5,
          childAspectRatio: 7,
          children: stationsData.stations,
        );
        final gridContainer = Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: stationsGridView,
        );

        final stationsView = Column(
          children: [
            titleBar,
            Expanded(child: gridContainer),
          ],
        );

        return Scaffold(
          body: SafeArea(child: Center(child: stationsView)),
          bottomSheet: const Footer(),
        );
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('Virhe: $error'))),
      loading: () => const Scaffold(body: Center(child: Text('ladataan'))),
    );
  }
}
