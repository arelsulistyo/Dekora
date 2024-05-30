// flower_service.dart
import 'package:dekora/models/flower_model.dart';

class FlowerService {
  static Future<List<Flower>> fetchFlowers() async {
    return [
      Flower(
        id: 1,
        name: 'Dahlia',
        imageUrl: 'assets/images/flower1.png',
        price: 31.4,
        type: 'Indoor',
        size: 'Medium',
        description:
            'Chrysanthemums, Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,Chrysanthemums,v or simply "mums," are vibrant flowers with diverse colors and shapes. They symbolize happiness and longevity in many cultures and are commonly used in celebrations like weddings and festivals. Mums are easy to grow in sunny spots and well-drained soil, making them perfect for gardens or containers.',
      ),
      Flower(
        id: 2,
        name: 'Roses',
        imageUrl: 'assets/images/flower2.png',
        price: 25.0,
        type: 'Outdoor',
        size: 'Small',
        description:
            'Roses are a symbol of love and romance. They come in a variety of colors and sizes and are perfect for gardens and bouquets.',
      ),
      Flower(
        id: 3,
        name: 'Roses',
        imageUrl: 'assets/images/flower2.png',
        price: 25.0,
        type: 'Outdoor',
        size: 'Small',
        description:
            'Roses are a symbol of love and romance. They come in a variety of colors and sizes and are perfect for gardens and bouquets.',
      ),
      Flower(
        id: 4,
        name: 'Roses',
        imageUrl: 'assets/images/flower2.png',
        price: 25.0,
        type: 'Outdoor',
        size: 'Small',
        description:
            'Roses are a symbol of love and romance. They come in a variety of colors and sizes and are perfect for gardens and bouquets.',
      ),
      Flower(
        id: 5,
        name: 'Roses',
        imageUrl: 'assets/images/flower2.png',
        price: 25.0,
        type: 'Outdoor',
        size: 'Small',
        description:
            'Roses are a symbol of love and romance. They come in a variety of colors and sizes and are perfect for gardens and bouquets.',
      ),
      Flower(
        id: 6,
        name: 'Roses',
        imageUrl: 'assets/images/flower2.png',
        price: 25.0,
        type: 'Outdoor',
        size: 'Small',
        description:
            'Roses are a symbol of love and romance. They come in a variety of colors and sizes and are perfect for gardens and bouquets.',
      ),
      // Add more flowers with complete details here
    ];
  }
}
