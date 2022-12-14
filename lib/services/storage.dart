import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepo {
  firebase_storage.FirebaseStorage storage =
  firebase_storage.FirebaseStorage.instanceFor(
      bucket: 'gs://circlink-de996.appspot.com/');


  uploadFile(){


  }

}