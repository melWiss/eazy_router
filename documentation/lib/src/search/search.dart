import 'package:documentation/src/home/desktop_home_body.dart';
import 'package:eazy_router/eazy_router_annotation.dart';
import 'package:eazy_router/eazy_router.dart';
import 'package:flutter/material.dart';

part 'search.g.dart';

@GenerateRoute(isAnonymous: true, transition: RouteTransitions.dialog)
class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Color(0xFF101017);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.sizeOf(context).height * .5,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: color,
                  child: Hero(
                    tag: 'search',
                    child: SearchField(
                      autoFocus: true,
                      hintText: 'Search through all documents...',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      elevation: 1,
                      child: ListTile(
                        tileColor: Theme.of(context).scaffoldBackgroundColor,
                        leading: Icon(Icons.set_meal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          'The title of the $index document/header (still not so sure)',
                        ),
                        subtitle:
                            Text('The part where you found the result...'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
