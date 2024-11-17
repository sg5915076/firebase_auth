import 'package:firebase_auth_flutter/firebase_service/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import 'login_screen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          unauthenticated: () {
            // Navigate to login screen when unauthenticated
            Navigator.pushReplacementNamed(context, '/login');
          },
          // Add other cases for other states (authenticated, loading, etc.)
          authenticated: (userId) {
            // Handle authenticated state
          },
          loading: () {
            // Handle loading state
          },
          error: (message) {
            // Handle error state
          }, initial: () => const Center(child: CircularProgressIndicator()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                print('Logout button pressed'); // Debugging
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('Welcome to Home Screen!'),
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Do you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logout());
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

