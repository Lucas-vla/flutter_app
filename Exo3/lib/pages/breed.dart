import 'package:exo3/services/catapi.dart';
import 'package:flutter/material.dart';
import '../models/breed.dart';

class BreedsPage extends StatefulWidget {
  final Breed breed;
  final catApi = CatApi();

  @override
  State<BreedsPage> createState() => _BreedPageState();
}
class _BreedPageState extends State<BreedsPage> {

}