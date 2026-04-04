import 'state.dart';

const List<FoodItem> kMenuItems = [
  FoodItem(
    id: '1',
    name: 'Jollof Power Bowl',
    category: 'Bowls',
    price: 8.90,
    rating: 4.8,
    eta: '18-24 min',
    description:
        'Rich, smoky jollof rice cooked in a tomato base, served with grilled chicken and sweet plantain.',
    imageUrl:
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '2',
    name: 'Spicy Crunch Burger',
    category: 'Burgers',
    price: 9.40,
    rating: 4.7,
    eta: '14-20 min',
    description:
        'Double smash patty, habanero mayo, crispy onions, pickles and smoky cheddar in a toasted brioche bun.',
    imageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '3',
    name: 'Garden Glow Salad',
    category: 'Salads',
    price: 7.25,
    rating: 4.6,
    eta: '12-16 min',
    description:
        'Rocket, cherry tomatoes, cucumber and avocado dressed in a lemon-herb vinaigrette.',
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '4',
    name: 'Mango Chill Smoothie',
    category: 'Drinks',
    price: 3.80,
    rating: 4.9,
    eta: '8-12 min',
    description:
        'Frozen mango blended with coconut milk and a squeeze of lime. Refreshing and dairy-free.',
    imageUrl:
        'https://images.unsplash.com/photo-1553279768-865429fa0078?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '5',
    name: 'Smoky Chicken Bowl',
    category: 'Bowls',
    price: 10.20,
    rating: 4.8,
    eta: '16-22 min',
    description:
        'Jerk chicken, coconut rice, black beans, avocado and freshly made mango salsa.',
    imageUrl:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '6',
    name: 'Crispy Cheese Burger',
    category: 'Burgers',
    price: 8.70,
    rating: 4.5,
    eta: '15-21 min',
    description:
        'Classic beef patty, triple cheddar melt, iceberg lettuce, tomato and our signature KokoSpot sauce.',
    imageUrl:
        'https://images.unsplash.com/photo-1550547660-d9450f859349?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '7',
    name: 'Pepperoni Pizza',
    category: 'Pizza',
    price: 12.50,
    rating: 4.7,
    eta: '20-28 min',
    description:
        'Stone-baked thin crust, rich tomato sauce, mozzarella and generous slices of spicy pepperoni.',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '8',
    name: 'Loaded Fries',
    category: 'Snacks',
    price: 5.50,
    rating: 4.6,
    eta: '10-15 min',
    description:
        'Thick-cut golden fries loaded with cheese sauce, jalapeños, bacon bits and sour cream.',
    imageUrl:
        'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '9',
    name: 'Fresh Orange Juice',
    category: 'Drinks',
    price: 3.20,
    rating: 4.8,
    eta: '8-12 min',
    description:
        'Freshly squeezed from Valencia oranges. No added sugar. Served chilled.',
    imageUrl:
        'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500&fit=crop&auto=format&q=80',
  ),
  FoodItem(
    id: '10',
    name: 'Avocado Crunch Toast',
    category: 'Salads',
    price: 8.00,
    rating: 4.7,
    eta: '12-16 min',
    description:
        'Sourdough toast with smashed avocado, cherry tomatoes, feta, chilli flakes and a poached egg.',
    imageUrl:
        'https://images.unsplash.com/photo-1541519227354-08fa5d50c820?w=500&fit=crop&auto=format&q=80',
  ),
];

const List<String> kCategories = [
  'All',
  'Bowls',
  'Burgers',
  'Pizza',
  'Salads',
  'Drinks',
  'Snacks',
];

String categoryEmoji(String category) {
  switch (category) {
    case 'Bowls':
      return '🍲';
    case 'Burgers':
      return '🍔';
    case 'Salads':
      return '🥗';
    case 'Drinks':
      return '🥤';
    case 'Pizza':
      return '🍕';
    case 'Snacks':
      return '🍟';
    default:
      return '🍽️';
  }
}
