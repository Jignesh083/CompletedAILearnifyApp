import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { FlatList, Image, Pressable, StyleSheet, Text, View } from 'react-native';

type PaidCourse = {
  id: string;
  title: string;
  subtitle: string;
  icon: keyof typeof Ionicons.glyphMap;
};

const PAID_COURSES: PaidCourse[] = [
  {
    id: 'PAID_DSA',
    title: 'Paid DSA',
    subtitle: 'Advanced Data Structures',
    icon: 'lock-closed-outline',
  },
  {
    id: 'PAID_JAVA',
    title: 'Paid Java',
    subtitle: 'Advanced Java Concepts',
    icon: 'lock-closed-outline',
  },
  {
    id: 'rl_full_course',
    title: 'Paid RL',
    subtitle: 'Reinforcement Learning Advanced',
    icon: 'lock-closed-outline',
  },
  {
    id: 'PAID_PYTHON',
    title: 'Paid Python',
    subtitle: 'Advanced Python Programming',
    icon: 'lock-closed-outline',
  },
  {
    id: 'PAID_OS',
    title: 'Paid OS',
    subtitle: 'Advanced Operating System',
    icon: 'lock-closed-outline',
  },
];

export default function PaidCoursesScreen() {

  const router = useRouter();

  const handleNavigation = (courseId: string) => {

    // ✅ RL Course
    if (courseId === "rl_full_course") {
      router.push({
        pathname: "/paid-rl",
        params: { course: courseId }
      });
      return;
    }

    // ✅ Default (बाकी सब)
    router.push({
      pathname: "/paid-dsa",
      params: { course: courseId }
    });
  };

  const renderItem = ({ item }: { item: PaidCourse }) => (
    <Pressable
      style={styles.card}
      onPress={() => handleNavigation(item.id)}
    >
      <Ionicons name={item.icon} size={24} color="#9B1C1C" />

      <View style={styles.textContainer}>
        <Text style={styles.cardTitle}>{item.title}</Text>
        <Text style={styles.cardSubtitle}>{item.subtitle}</Text>
      </View>

      <Ionicons name="chevron-forward" size={18} color="#9B1C1C" />
    </Pressable>
  );

  return (
    <View style={styles.container}>

      <View style={styles.header}>
        <Image
          source={require('../../assets/images/logo.png')}
          style={styles.logo}
        />
        <Text style={styles.companyName}>AILearnify</Text>
      </View>

      <Text style={styles.heading}>💰 Paid Courses</Text>

      <FlatList
        data={PAID_COURSES}
        keyExtractor={(item) => item.id}
        renderItem={renderItem}
        showsVerticalScrollIndicator={false} // 🔥 smooth UI
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff', padding: 16 },

  heading: {
    fontSize: 18,
    fontWeight: '700',
    color: '#9B1C1C',
    marginBottom: 14,
  },

  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFF3F3',
    padding: 14,
    borderRadius: 14,
    marginBottom: 12,
  },

  textContainer: {
    flex: 1,
    marginLeft: 12,
  },

  cardTitle: { fontSize: 15, fontWeight: '700', color: '#222' },

  cardSubtitle: { fontSize: 12, color: '#666', marginTop: 2 },

  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
    marginTop: 30,
  },

  logo: { width: 45, height: 45, resizeMode: 'contain', marginRight: 8 },

  companyName: { fontSize: 16, fontWeight: '600', color: '#123C7B' },
});