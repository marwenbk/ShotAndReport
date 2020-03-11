import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fluster/fluster.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../provider/articles.dart';
class MapMarker extends Clusterable {
   final String id;
   final LatLng position;
   final BitmapDescriptor icon;

MapMarker({
   @required this.id,
   @required this.position,
   @required this.icon,
   isCluster = false,
   clusterId,
   pointsSize,
   childMarkerId,
   }) : super(
         markerId: id,
         latitude: position.latitude,
         longitude: position.longitude,
         isCluster: isCluster,
         clusterId: clusterId,
         pointsSize: pointsSize,
         childMarkerId: childMarkerId,
      );

Marker toMarker() => Marker(
         markerId: MarkerId(id),
         position: LatLng(
         position.latitude,
         position.longitude,
         ),
         icon: icon,
      );
      
}

class MapScreen extends StatefulWidget {
  static const pageRoute = '/map';
  final LatLng initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const LatLng(37.422, -122.084),
    this.isSelecting = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor customIcon;
  Set<Marker> markers = Set.from([]);
  List<String> links = [];
  var load = true;
  @override
  void didChangeDependencies() {
    if (load) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      final pois = Provider.of<Articles>(context, listen: false).articles;

      for (int i = 0; i < links.length; i++) {
        BitmapDescriptor.fromAssetImage(
                configuration, 'asset/icons/electricity.png')
            .then((icon) {
          setState(() {
            customIcon = icon;
          });
        });

        Marker m = Marker(markerId: MarkerId(links[i]), position: pois[i].poi);
        markers.add(m);
        setState(() {
          load = false;
        });
      }
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: widget.initialLocation,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
