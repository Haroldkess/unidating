
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
final usersRef = _fireStore.collection('users');
final postRef = _fireStore.collection('posts');
final pricingRef = _fireStore.collection('pricing');

final subPeriod = _fireStore.collection('paidUsers');