import 'package:flutter/material.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _NavbarState createState() => _NavbarState();
  Size get preferredSize => Size.fromHeight(56.0);
}

class _NavbarState extends State<Navbar> {
  Map<String, Color> itemColors = {
    'Detalles': Color(0xFF1D1818),
    'Rutinas': Color(0xFF1D1818),
    'Perfil': Color(0xFF1D1818),
    'Ejercicios': Color(0xFF1D1818),
  };
  Color hoverColor = Color(0xFFD60909);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: hoverColor,
              ),
              onPressed: () {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final position = renderBox.localToGlobal(Offset.zero);

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    position.dx,
                    position.dy + kToolbarHeight,
                    position.dx + renderBox.size.width,
                    position.dy + kToolbarHeight + renderBox.size.height,
                  ),
                  items: [
                    _buildMobilePopupMenuItem(
                        'Ejercicios', Icons.assignment, '/ejercicios'),
                    _buildMobilePopupMenuItem(
                        'Rutinas', Icons.fitness_center, '/rutinas'),
                    _buildMobilePopupMenuItem(
                        'Perfil', Icons.person, '/perfil'),
                    _buildMobilePopupMenuItem(
                        'Detalles', Icons.auto_stories, '/detalles'),
                  ],
                );
              },
            ),
            Spacer(),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem('Ejercicios', Icons.assignment, '/ejercicios'),
            _buildNavItem('Rutinas', Icons.fitness_center, '/rutinas'),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
            _buildNavItem('Perfil', Icons.person, '/perfil'),
            _buildNavItem('Detalles', Icons.auto_stories, '/detalles'),
          ],
        ),
      );
    }
  }

  PopupMenuItem<String> _buildMobilePopupMenuItem(
      String label, IconData icon, String route) {
    return PopupMenuItem<String>(
      value: route,
      child: Row(
        children: [
          Icon(icon, color: hoverColor),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: hoverColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            itemColors[label] = hoverColor;
          });
        },
        onExit: (_) {
          setState(() {
            itemColors[label] = Color(0xFF1D1818);
          });
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: itemColors[label],
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: itemColors[label],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
