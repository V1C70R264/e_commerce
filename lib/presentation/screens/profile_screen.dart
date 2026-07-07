import 'package:e_commerce/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/data/datasources/remote/user_remote_datasource.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/presentation/cubit/profile_cubit.dart';
import 'package:e_commerce/presentation/cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.user != null) {
          final user = state.user;
          final username = user!.username ?? '';
          final email = user.email;
          // Backend does not provide phone number; use placeholder to avoid UI breaks
          final phone_number = 'Not provided';

          return CustomScrollView(
            slivers: [
              // Custom App Bar with Profile Header
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: null,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final mediaTop = MediaQuery.of(context).padding.top;
                    const expanded = 200.0;
                    final toolbar = kToolbarHeight + mediaTop;
                    final h = constraints.maxHeight.clamp(toolbar, expanded);
                    final t = ((h - toolbar) / (expanded - toolbar)).toDouble();
                    final smallOpacity = (1.0 - t).clamp(0.0, 1.0);
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  (() {
                                    final hasNetImage = (user.profileImage !=
                                            null &&
                                        user.profileImage!.trim().isNotEmpty);
                                    return CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : (hasNetImage
                                              ? NetworkImage(user.profileImage!)
                                              : null),
                                      child: (_profileImage == null &&
                                              !hasNetImage)
                                          ? Text(
                                              _initialsFor(
                                                  username: username,
                                                  fullName: user.fullName,
                                                  email: email),
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 28,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )
                                          : null,
                                    );
                                  })(),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (_) => SafeArea(
                                            child: Wrap(
                                              children: [
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.camera_alt),
                                                  title: Text('Take Photo'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _pickImage(
                                                        ImageSource.camera);
                                                  },
                                                ),
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.photo_library),
                                                  title: Text(
                                                      'Choose from Gallery'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _pickImage(
                                                        ImageSource.gallery);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.camera_alt,
                                            color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (username.isNotEmpty)
                                Text(
                                  username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Text(
                                email,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                phone_number,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Collapsed (small) avatar + username shown when scrolled
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: mediaTop + 12, left: 56, right: 16),
                            child: Opacity(
                              opacity: smallOpacity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (() {
                                    final hasNetImage = (user.profileImage !=
                                            null &&
                                        user.profileImage!.trim().isNotEmpty);
                                    return CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.15),
                                      backgroundImage: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : (hasNetImage
                                              ? NetworkImage(user.profileImage!)
                                              : null),
                                      child: (_profileImage == null &&
                                              !hasNetImage)
                                          ? Text(
                                              _initialsFor(
                                                  username: username,
                                                  fullName: user.fullName,
                                                  email: email),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : null,
                                    );
                                  })(),
                                  const SizedBox(width: 8),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                actions: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        // TODO: Navigate to edit profile screen
                      } else if (value == 'settings') {
                        // TODO: Navigate to settings screen
                      } else if (value == 'logout') {
                        await UserRemoteDatasourceImpl().logout();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit Profile'),
                      ),
                      const PopupMenuItem(
                        value: 'settings',
                        child: Text('Settings'),
                      ),
                      const PopupMenuItem(
                        value: 'logout',
                        child: Text('Log Out'),
                      ),
                    ],
                  ),
                ],
              ),

              // Stats Section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _buildStatItem('Orders', '12', 'Completed'),
                      _buildStatItem('Points', '1,208', 'Earned'),
                      _buildStatItem('Level', 'Gold', 'Member'),
                    ],
                  ),
                ),
              ),

              // Menu Items
              SliverList(
                delegate: SliverChildListDelegate([
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    subtitle: 'View your order history',
                    badgeCount: 2,
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    subtitle: 'Your favorite items',
                    badgeCount: 5,
                  ),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    subtitle: 'Manage delivery addresses',
                  ),
                  _buildMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Manage your payment options',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Customize notifications',
                    showToggle: true,
                  ),
                  _buildMenuItem(
                    icon: Icons.language_outlined,
                    title: 'Language',
                    subtitle: 'English (US)',
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get help with your orders',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () async {
                        await UserRemoteDatasourceImpl().logout();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ]),
              ),
            ],
          );
        } else if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container(); // or your initial state widget
      },
    );
  }

  File? _profileImage;

  String _initialsFor(
      {required String username, String? fullName, required String email}) {
    // Prefer first letter of first name + first letter of last name
    if (fullName != null && fullName.trim().isNotEmpty) {
      final parts = fullName
          .trim()
          .split(RegExp(r"\s+"))
          .where((p) => p.isNotEmpty)
          .toList();
      if (parts.isNotEmpty) {
        final first = parts.first;
        final last = parts.length > 1 ? parts.last : '';
        final a = first.isNotEmpty ? first[0] : '';
        final b =
            last.isNotEmpty ? last[0] : (first.length > 1 ? first[1] : '');
        final res = (a + b).toUpperCase();
        if (res.trim().isNotEmpty) return res;
      }
    }
    // Fallbacks
    final u = username.trim();
    if (u.isNotEmpty) {
      return u.substring(0, u.length >= 2 ? 2 : 1).toUpperCase();
    }
    final local = email.split('@').first;
    if (local.isNotEmpty) {
      final parts =
          local.split(RegExp(r'[\s._-]+')).where((p) => p.isNotEmpty).toList();
      if (parts.length >= 2) {
        return (parts.first[0] + parts.last[0]).toUpperCase();
      }
      return local.substring(0, local.length >= 2 ? 2 : 1).toUpperCase();
    }
    return '?';
  }

  Widget _buildStatItem(String label, String value, String subtitle) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    int? badgeCount,
    bool showToggle = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badgeCount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (showToggle)
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.green,
              )
            else
              const Icon(Icons.chevron_right, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _uploadProfileImage();
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_profileImage == null) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token == null) {
      // Handle not logged in
      return;
    }

    final uri = Uri.parse('${AppConstants.baseUrl}users/me/');
    final request = http.MultipartRequest('PATCH', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
          'profile_image', _profileImage!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      // Success: Optionally refresh user data
      context.read<ProfileCubit>().fetchUserProfile();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Profile image updated!'),
            backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to upload image'),
            backgroundColor: Colors.red),
      );
    }
  }
}
