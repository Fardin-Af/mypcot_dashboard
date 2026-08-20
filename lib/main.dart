import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MypcotApp());
}

class MypcotApp extends StatelessWidget {
  const MypcotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mypcot',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3D63),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  int _bottomIndex = 0;

  final List<DashboardCardData> cards = const [
    DashboardCardData(
      type: CardType.orders,
      color: Color(0xFF33A1CC),
      title: 'Orders',
      image: 'assets/orders-illustration-image.svg',
      buttonText: 'Orders',
    ),
    DashboardCardData(
      type: CardType.subscriptions,
      color: Color(0xFFDCB223),
      title: 'Subscriptions',
      image: 'assets/subscriptions-illustration-image.svg',
      buttonText: 'Subscriptions',
    ),
    DashboardCardData(
      type: CardType.customers,
      color: Color(0xFF31CE95),
      title: 'Customers',
      image: 'assets/customers-illustration-image.svg',
      buttonText: 'View Customers',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 38),
              _buildWelcome(),
              const SizedBox(height: 20),
              _buildCarousel(),
              const SizedBox(height: 24),
              _buildDateHeader(),
              const SizedBox(height: 18),
              _buildDateStrip(),
              const SizedBox(height: 8),
              _buildActivityCard(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 8,
        backgroundColor: const Color(0xFF2C3D63),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _circleButton(Widget child) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        _circleButton(
          const Icon(
            Icons.menu,
            color: Color(0xFF2C3D63),
            size: 23,
          ),
        ),
        const Spacer(),
        _circleButton(
          const Icon(
            Icons.favorite_border,
            color: Color(0xFF2C3D63),
            size: 23,
          ),
        ),
        const SizedBox(width: 12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _circleButton(
              const Icon(
                Icons.notifications_none_outlined,
                color: Color(0xFF2C3D63),
                size: 24,
              ),
            ),
            Positioned(
              right: -2,
              top: -4,
              child: Container(
                width: 19,
                height: 19,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7043),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            color: Color(0xFFF2B65D),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcome() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome, Mypcot !!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3D63),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'here is your dashboard....',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7D899D),
                ),
              ),
            ],
          ),
        ),
        _circleButton(
          const Icon(
            Icons.search,
            color: Color(0xFF2C3D63),
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 1000,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index % cards.length;
              });
            },
            itemBuilder: (context, index) {
              return _buildDashboardCard(cards[index % cards.length]);
            },
          ),
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cards.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? const Color(0xFF2C3D63)
                    : const Color(0xFFD6DAE2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard(DashboardCardData data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: data.color,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 18,
            top: 27,
            child: SizedBox(
              width: 105,
              height: 105,
              child: SvgPicture.asset(
                data.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 18,
            bottom: 13,
            child: _cardButton(data.buttonText, _buttonColor(data.type)),
          ),
          if (data.type == CardType.orders) ...[
            Positioned(
              right: 18,
              top: 9,
              child: _statBox(
                width: 135,
                height: 62,
                color: const Color(0xFFE64A19),
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'You have ',
                      children: [
                        TextSpan(
                          text: '3',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: ' active\norders from'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.15,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 76,
              child: _statBox(
                width: 135,
                height: 66,
                color: Colors.white,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '02 ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'Pending\nOrders from',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2C3D63),
                    height: 1.25,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 35,
              top: 54,
              child: _avatars(3),
            ),
            Positioned(
              right: 47,
              top: 128,
              child: _avatars(2),
            ),
          ],
          if (data.type == CardType.subscriptions) ...[
            Positioned(
              right: 18,
              top: 8,
              child: _statBox(
                width: 135,
                height: 58,
                color: const Color(0xFF234DDC),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '03 ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: 'deliveries'),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 70,
              child: _statBox(
                width: 108,
                height: 48,
                color: Colors.white,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '10 ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: 'Active\nSubscriptions'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2C3D63),
                    fontSize: 10,
                    height: 1.05,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 122,
              child: _statBox(
                width: 108,
                height: 48,
                color: Colors.white,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '119 ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: 'Pending\nDeliveries'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2C3D63),
                    fontSize: 10,
                    height: 1.05,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 44,
              top: 51,
              child: _avatars(3),
            ),
          ],
          if (data.type == CardType.customers) ...[
            Positioned(
              right: 18,
              top: 8,
              child: _statBox(
                width: 135,
                height: 53,
                color: const Color(0xFFE6005C),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '15 ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: 'New customers'),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 64,
              child: _graphBox(),
            ),
            Positioned(
              right: 48,
              top: 46,
              child: _avatars(3),
            ),
            Positioned(
              right: 42,
              bottom: 13,
              child: _statBox(
                width: 108,
                height: 52,
                color: Colors.white,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '10 ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: 'Active\nCustomers'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2C3D63),
                    fontSize: 10,
                    height: 1.05,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 21,
              bottom: 22,
              child: _avatars(3),
            ),
          ],
        ],
      ),
    );
  }

  Color _buttonColor(CardType type) {
    switch (type) {
      case CardType.orders:
        return const Color(0xFFE64A19);
      case CardType.subscriptions:
        return const Color(0xFF234DDC);
      case CardType.customers:
        return const Color(0xFFE6005C);
    }
  }

  Widget _cardButton(String text, Color color) {
    return Container(
      width: 110,
      height: 33,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statBox({
    required double width,
    required double height,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _avatars(int count) {
    const colors = [
      Color(0xFFEF5350),
      Color(0xFF5C6BC0),
      Color(0xFFFFA726),
    ];

    return SizedBox(
      width: 22.0 + ((count - 1) * 16.0),
      height: 24,
      child: Stack(
        children: List.generate(count, (index) {
          return Positioned(
            left: index * 16.0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 14,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _graphBox() {
    return Container(
      width: 115,
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            '1.8%',
            style: TextStyle(
              color: Color(0xFF2C3D63),
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.trending_up,
            color: Color(0xFF00C98B),
            size: 27,
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    final now = DateTime.now();

    final month = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][now.month - 1];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 78,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$month, ${now.day} ${now.year}',
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF718096),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2C3D63),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 6),

        SizedBox(
          width: 96,
          height: 30,
          child: _buildDatePill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'TIMELINE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2C3D63),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF58708F),
                  size: 16,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 6),

        SizedBox(
          width: 86,
          height: 30,
          child: _buildDatePill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF58708F),
                  size: 15,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_monthShort(now.month)}, ${now.year}',
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2C3D63),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePill({required Widget child}) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  String _monthShort(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    return months[month - 1];
  }

  Widget _timelineButton() {
    return Container(
      height: 44,
      width: 132,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TIMELINE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3D63),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF536A91),
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _monthButton() {
    return Container(
      height: 44,
      width: 128,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 20,
            color: Color(0xFF536A91),
          ),
          SizedBox(width: 7),
          Text(
            'JAN, 2021',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3D63),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateStrip() {
    final now = DateTime.now();

    final startDate = now.subtract(
      Duration(days: now.weekday - 1),
    );

    final dates = List.generate(
      7,
          (index) => startDate.add(Duration(days: index)),
    );

    const weekdays = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dates.map((date) {
        final selected =
            date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;

        return SizedBox(
          width: 40,
          child: Column(
            children: [
              Text(
                weekdays[date.weekday - 1],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected
                      ? const Color(0xFF009E91)
                      : const Color(0xFFB6C3D1),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: selected
                      ? const Color(0xFF009E91)
                      : const Color(0xFF2C3D63),
                ),
              ),
              const SizedBox(height: 10),
              if (selected)
                Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    color: Color(0xFF009E91),
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 13),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActivityCard() {
    return Container(
      height: 140,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New order created',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3D63),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'New Order created with Order',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF707A89),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '09:00 AM',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF7043),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: Color(0xFFFFEEE8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFFFF7043),
              size: 38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomAppBar(
      height: 72,
      color: Colors.white,
      elevation: 12,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, 'Home', 0),
          _navItem(Icons.people_outline, 'Customers', 1),
          const SizedBox(width: 54),
          _navItem(Icons.account_balance_wallet_outlined, 'Khata', 2),
          _navItem(Icons.shopping_bag_outlined, 'Orders', 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final selected = _bottomIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _bottomIndex = index;
        });
      },
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 21,
              color: selected
                  ? const Color(0xFF2C3D63)
                  : const Color(0xFF94A0B3),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? const Color(0xFF2C3D63)
                    : const Color(0xFF94A0B3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CardType {
  orders,
  subscriptions,
  customers,
}

class DashboardCardData {
  final CardType type;
  final Color color;
  final String title;
  final String image;
  final String buttonText;

  const DashboardCardData({
    required this.type,
    required this.color,
    required this.title,
    required this.image,
    required this.buttonText,
  });
}
