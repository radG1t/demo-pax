import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textController = TextEditingController();
  final searchController = TextEditingController();
  final replaceController = TextEditingController();

  String previousText = '';
  String previousSearch = '';
  String previousReplace = '';
  final Uri _url = Uri.parse('https://daramet.com/supportradin');

  @override
  void initState() {
    super.initState();
    previousText = '';
    previousSearch = '';
    previousReplace = '';
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    textController.dispose();
    searchController.dispose();
    replaceController.dispose();
    super.dispose();
  }

  void _pax() {
    final String text = textController.text;
    final String search = searchController.text;
    final String replace = replaceController.text;

    if (text.isEmpty || search.isEmpty || replace.isEmpty) {
      return;
    }

    setState(() {});

    final String newText = text.replaceAll(search, replace);
    previousText = text;
    previousSearch = search;
    previousReplace = replace;

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        textController.text = newText;
      });
    });
  }

  void _dePax() {
    setState(() {
      textController.text = previousText;
      searchController.text = previousSearch;
      replaceController.text = previousReplace;
      previousText = '';
      previousSearch = '';
      previousReplace = '';
    });
  }

  void _reset() {
    setState(() {
      textController.clear();
      searchController.clear();
      replaceController.clear();
      previousText = '';
      previousSearch = '';
      previousReplace = '';
    });
  }

  // ui
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(55, 30, 55, 0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                minLines: 15,
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Enter your text here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'replace this ..',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: replaceController,
                      decoration: InputDecoration(
                        hintText: 'with this ..',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () => _pax(),
                      child: Container(
                        width: 70,
                        height: 35,
                        color: Colors.black38,
                        child: const Center(
                            child: Text('PaX',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () => _dePax(),
                      child: Container(
                        width: 70,
                        height: 35,
                        color: Colors.black38,
                        child: const Center(
                            child: Text(
                          'dePax',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _dePax(),
                    child: Container(
                      width: 71,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black38,
                      ),
                      child: DropdownButton<String>(
                        underline: Container(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        isExpanded: false,
                        onChanged: (String? value) {
                          if (value == 'copy') {
                            Clipboard.setData(
                                ClipboardData(text: textController.text));
                          } else if (value == 'reset') {
                            _reset();
                          }
                          //else if (value == 'twitter') {   }
                          else if (value == 'pizza') {
                            GestureDetector(
                              onTap: () => _launchUrl,
                            );
                          }
                        },
                        items: [
                          const DropdownMenuItem(
                            value: 'copy',
                            child: Center(
                              child: Text(
                                'Copy',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const DropdownMenuItem(
                            value: 'reset',
                            child: Center(
                              child: Text(
                                'Reset',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          /* DropdownMenuItem(
                            value: 'twitter',
                            child: Center(
                              child: Image.asset(
                                color: Colors.white,
                                "assets/twitter.png",
                                width: 28,
                              ),
                            ),
                          ),*/
                          DropdownMenuItem(
                            value: 'pizza',
                            child: Center(
                              child: Image.asset(
                                color: Colors.white,
                                "assets/pizza.png",
                                width: 28,
                              ),
                            ),
                          ),
                        ],
                        hint: const Center(
                            child: Text(
                          '      etc',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        focusColor: Colors.grey,
                        dropdownColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              const Text('درود :D \n مرسی که از ابزار پکسورد استفاده کردی'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
