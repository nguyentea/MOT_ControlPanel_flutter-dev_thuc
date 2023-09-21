import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
class StorageSearchPage extends StatefulWidget {
  @override
  _StorageSearchPageState createState() => _StorageSearchPageState();
}

class _StorageSearchPageState extends State<StorageSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _fileList = [];
  List<String> _searchResultList = [];

  //late Future<firebase_storage.ListResult> futureFiles;
  Future<firebase_storage.ListResult> futureFiles = firebase_storage.FirebaseStorage.instance.ref('/Video').listAll();
  List<firebase_storage.Reference> _list_ref = [];

  Map<int, double> downloadProgress = {};

  Future downloadFile(int index, firebase_storage.Reference ref) async {

    final url = await ref.getDownloadURL();

    //final Directory directory = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    print('Video downloaded to $path');


    await Dio().download(
      url,
      path,
      onReceiveProgress: (receied, total) {
        double progress = receied / total;
        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('ipg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download: ${ref.name}")),
    );
  }




  @override
  void initState() {
    super.initState();
    //firebase_storage.ListResult result = firebase_storage.FirebaseStorage.instance.ref('/Video').listAll();
    //futureFiles = firebase_storage.FirebaseStorage.instance.ref('/Video').listAll();
    _getFileListFromStorage();
    getFileReferences();
  }

  void _getFileListFromStorage() async {
    firebase_storage.ListResult result =
    await firebase_storage.FirebaseStorage.instance.ref('/Video').listAll();
    List<String> fileList = [];
    for (var item in result.items) {
      fileList.add(item.name);
    }

    setState(() {
      _fileList = fileList;
    });
  }

  List<String> _searchFileList(String searchQuery) {
    return _fileList
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void _performSearch(String searchQuery) {
    setState(() {
      _searchResultList = _searchFileList(searchQuery);
    });
  }

  void getFileReferences() async {
    firebase_storage.ListResult result =
    await firebase_storage.FirebaseStorage.instance.ref('/Video').listAll();
    List<firebase_storage.Reference> list_ref = [];
    for (var item in result.items) {
      firebase_storage.Reference ref = item;
      list_ref.add(ref);
    }
    print(list_ref[1]);
    setState(() {
      _list_ref = list_ref;
    });
    //return result.items[index];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Violation search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _performSearch(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResultList.length,
              itemBuilder: (context, index) {


                double? progress = downloadProgress[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.deepPurpleAccent, //<-- SEE HERE
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Text(_searchResultList[index]),
                  subtitle: progress != null
                      ? LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.black26,
                  )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      getFileReferences();
                      _searchResultList[index]== _list_ref[index].name?
                      downloadFile(index, _list_ref[index] ) : downloadFile(index, _list_ref[index]);
                      //getFileReferences(index);
                      },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
