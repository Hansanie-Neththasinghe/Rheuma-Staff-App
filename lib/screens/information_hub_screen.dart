import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/info_hub_provider.dart';
import '../models/info_hub.dart';
import 'view_one_article_screen.dart';

class InformationHubScreen extends StatefulWidget {
  const InformationHubScreen({super.key});

  @override
  _InformationHubScreenState createState() => _InformationHubScreenState();
}

class _InformationHubScreenState extends State<InformationHubScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = ''; // Search query state

  @override
  void initState() {
    super.initState();
    // Fetch all articles when the screen is first loaded
    Provider.of<InfoHubProvider>(context, listen: false).getAllInfoArticles();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<InfoHubProvider>(context);
    final articles = articleProvider.infoArticles;

    // Filtered articles based on search query
    final filteredArticles = articles.where((article) {
      return article.name.toLowerCase().contains(searchQuery) ||
             article.category.toLowerCase().contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Hub'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search articles',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query.toLowerCase(); // Update search query
                });
              },
            ),
            const SizedBox(height: 20.0),

            // Display filtered articles
            Expanded(
              child: filteredArticles.isEmpty
                  ? const Center(
                      child: Text(
                        'No articles found.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];
                        return _buildArticleCard(article);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual article cards with a beautiful design
  Widget _buildArticleCard(InfoHub article) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article name as the title
            Text(
              article.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10.0),
            // Category text
            Row(
              children: [
                const Icon(Icons.category, color: Colors.blueAccent, size: 18),
                const SizedBox(width: 5),
                Text(
                  article.category,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Article description (trimmed)
            Text(
              article.doc.length > 100
                  ? '${article.doc.substring(0, 100)}...'
                  : article.doc,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10.0),
            // Read more button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to ViewOneArticleScreen with article details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewOneArticleScreen(article: article),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('Read More'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
