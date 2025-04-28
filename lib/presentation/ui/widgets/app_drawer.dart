import 'package:cgpa/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                SizedBox(height: 16),
                SvgPicture.asset(AssetsPath.logo, width: 50),
                SizedBox(height: 8),
                Text(
                  "Daffodil International University",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white,overflow: TextOverflow.ellipsis,fontSize: 22,fontWeight: FontWeight.w300),
                ),
                Text(
                  "Semester Result",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Compare Result"),
            leading: Icon(Icons.compare),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            title: Text("Open Website"),
            leading: Icon(Icons.web),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            title: Text("Rate This App"),
            leading: Icon(Icons.star_border),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            title: Text("Share App"),
            leading: Icon(Icons.share),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            title: Text("More App"),
            leading: Icon(Icons.devices_rounded),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
          // Spacer pushes the content to the bottom
          Spacer(),
          // Developer info at the bottom
          Column(
            children: [
              SizedBox(height: 8),
              Text("Developer : Md Bappy",style: TextStyle(color: Colors.grey),),
              Text("Batch: 61",style: TextStyle(color: Colors.grey),),
              Text("Version 1.0.0",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 8)
            ],
          ),
        ],
      ),
    );
  }
}
