import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import {
  Alert,
  Image,
  Linking,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import Animated, {
  useAnimatedStyle,
  useSharedValue,
  withTiming,
} from 'react-native-reanimated';

/* =====================================================
   ROUTE TYPES
===================================================== */
type AppRoute =
  | '/all-courses'
  | '/paid-courses'
  | '/leaderboard'
  | '/daily-subjects'
  | '/reports'
  | '/app-info'
  | '/login'
  | '/syllabus'; // add this
/* =====================================================
   FEATURE TYPE
===================================================== */
type FeatureItem = {
  key: string;
  icon: keyof typeof Ionicons.glyphMap;
  label: string;
  color: string;
  route?: AppRoute;
  action?: () => void;
};

/* =====================================================
   REUSABLE ANIMATED BOX
===================================================== */
function AnimatedBox({
  icon,
  text,
  color,
  onPress,
}: {
  icon: keyof typeof Ionicons.glyphMap;
  text: string;
  color: string;
  onPress?: () => void;
}) {
  const scale = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  return (
    <Animated.View style={[styles.box, animatedStyle]}>
      <Pressable
        onPressIn={() => (scale.value = withTiming(0.92, { duration: 100 }))}
        onPressOut={() => (scale.value = withTiming(1, { duration: 100 }))}
        onPress={onPress}
        android_ripple={{ color: 'rgba(255,255,255,0.15)' }}
        style={{ alignItems: 'center' }}
      >
        <Ionicons name={icon} size={28} color={color} />
        <Text style={styles.boxText}>{text}</Text>
      </Pressable>
    </Animated.View>
  );
}

/* =====================================================
   DASHBOARD
===================================================== */
export default function Dashboard() {
  const router = useRouter();

  function handleRateUs() {
    Alert.alert(
      'Rate Us ⭐',
      'If you like AI Learnify, please rate us on Play Store',
      [
        { text: 'Later', style: 'cancel' },
        {
          text: 'Rate Now',
          onPress: () =>
            Linking.openURL('https://play.google.com/store/apps/details?id=com.ailearnify'),
        },
      ]
    );
  }

  const FEATURES: FeatureItem[] = [
    {
      key: 'freeCourses',
      icon: 'book',
      label: 'Courses',
      color: '#FFD166',
      route: '/all-courses',
    },
    // {
    //   key: 'paidCourses',
    //   icon: 'book',
    //   label: 'Paid Courses',
    //   color: '#06D6A0',
    //   route: '/paid-courses',
    // },
    {
      key: 'syllabus',
      icon: 'book-outline',
      label: 'Syllabus Details',
      color: '#38B000',
      route: '/syllabus',
    },
    {
      key: 'quiz',
      icon: 'create',
      label: 'Daily Quiz',
      color: '#8338EC',
      route: '/daily-subjects',   // ✅ UPDATED HERE
    },
    
    {
      key: 'leaderboard',
      icon: 'trophy',
      label: 'Leaderboard',
      color: '#4D96FF',
      route: '/leaderboard',
    },
    {
      key: 'rate',
      icon: 'star',
      label: 'Rate Us',
      color: '#FFB703',
      action: handleRateUs,
    },
    {
      key: 'info',
      icon: 'information-circle',
      label: 'App Info',
      color: '#6A4C93',
      route: '/app-info',
    },
  ];

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Image
          source={require('../../assets/images/logo.png')}
          style={styles.logo}
        />
        <Text style={styles.companyName}>AILearnify</Text>
      </View>

      {/* Feature Grid */}
      <View style={styles.grid}>
        {FEATURES.map((item) => (
          <AnimatedBox
            key={item.key}
            icon={item.icon}
            text={item.label}
            color={item.color}
            onPress={() => {
              if (item.route) router.push(item.route);
              if (item.action) item.action();
            }}
          />
        ))}
      </View>
    </View>
  );
}

/* =====================================================
   STYLES
===================================================== */
const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#ffffff',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 30,
    marginBottom: 10,
  },
  logo: {
    width: 45,
    height: 45,
    resizeMode: 'contain',
    marginRight: 8,
  },
  companyName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#123C7B',
  },
  grid: {
    marginTop: 10,
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  box: {
    width: '48%',
    backgroundColor: '#123C7B',
    borderRadius: 14,
    paddingVertical: 22,
    marginBottom: 15,
    alignItems: 'center',
  },
  boxText: {
    color: '#fff',
    marginTop: 8,
    fontSize: 14,
    fontWeight: '600',
    textAlign: 'center',
  },
});