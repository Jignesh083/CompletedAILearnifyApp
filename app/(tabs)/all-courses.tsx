// import { Ionicons } from '@expo/vector-icons';
// import { useRouter } from 'expo-router';
// import { FlatList, Pressable, StyleSheet, Text, View } from 'react-native';

// type Course = {
//   id: string;
//   title: string;
//   subtitle: string;
//   icon: string;
// };

// const COURSES: Course[] = [
//   { id: 'DSA', title: 'DSA', subtitle: 'Data Structures & Algorithms', icon: 'git-branch' },

//   { id: 'Reinforcement_Learning', title: 'ReinforcementLearning', subtitle: 'Machine Learning - RL', icon: 'code-slash' },

//   { id: 'JAVA', title: 'Java', subtitle: 'Java Core Concepts', icon: 'code' },

//   { id: 'PYTHON', title: 'Python', subtitle: 'Python for Beginners', icon: 'logo-python' },

//   { id: 'OS', title: 'OS', subtitle: 'Operating System', icon: 'settings' },
// ];
// const PAID_COURSE_MAP: Record<string, string | null> = {
//   DSA: null,
//   ReinforcementLearning: 'rl_full_course',
//   JAVA: null,
//   PYTHON: null,
//   OS: null,
// };
// export default function AllCourses() {
//   const router = useRouter();

//   const renderItem = ({ item }: { item: Course }) => (
//     <Pressable
//       style={styles.card}
//       onPress={() => {
//      const bundleKey = PAID_COURSE_MAP[item.id];

// if (bundleKey) {
//   router.push('/paid-rl');   // RL paid preview screen
// } else {
//   router.push({
//     pathname: '/courselist',
//     params: { course: item.id },
//   });
// }
//       }}
//     >
//       <Ionicons name={item.icon as any} size={26} color="#123C7B" />

//       <View style={styles.textContainer}>
//         <Text style={styles.title}>{item.title}</Text>
//         <Text style={styles.subtitle}>{item.subtitle}</Text>
//         {PAID_COURSE_MAP[item.id] && (
//   <Text style={{ color: 'red', fontSize: 12, marginTop: 2 }}>
//     🔒 Paid Course
//   </Text>
// )}
//       </View>

//       <Ionicons name="chevron-forward" size={20} color="#999" />
//     </Pressable>
//   );

//   return (
//     <View style={styles.container}>
//       <Text style={styles.heading}>📚 Free Courses</Text>

//       <FlatList
//         data={COURSES}
//         keyExtractor={(item) => item.id}
//         renderItem={renderItem}
//       />
//     </View>
//   );
// }

// const styles = StyleSheet.create({
//   container: { flex: 1, padding: 16, backgroundColor: '#fff' },

//   heading: {
//     fontSize: 22,
//     fontWeight: '700',
//     marginBottom: 20,
//     marginTop: 40,
//     color: '#123C7B',
//   },

//   card: {
//     flexDirection: 'row',
//     alignItems: 'center',
//     backgroundColor: '#F3F6FB',
//     padding: 16,
//     borderRadius: 14,
//     marginBottom: 12,
//   },

//   textContainer: { flex: 1, marginLeft: 12 },

//   title: { fontSize: 16, fontWeight: '700', color: '#123C7B' },

//   subtitle: { fontSize: 13, color: '#555' },
// });









import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useEffect, useState } from 'react';
import {
  ActivityIndicator,
  FlatList,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';

const API = 'https://ailearnifyapp-tbrt.onrender.com';

type Course = {
  id: number;
  subject_name: string;
  subject_key: string;
  subtitle: string;
  icon: string;
  course_type: string;
  bundle_key: string | null;
};

export default function AllCourses() {
  const router = useRouter();

  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      const response = await fetch(`${API}/subjects`);

     const data = await response.json();

setCourses(data);


    } catch (error) {
      console.log('FETCH COURSES ERROR:', error);
    } finally {
      setLoading(false);
    }
  };

  const renderItem = ({ item }: { item: Course }) => (
    <Pressable
      style={styles.card}
      onPress={() =>
        router.push({
          pathname: '/courselist',
params: {
  course: item.subject_key,
},
        })
      }
    >
      <Ionicons
        name={(item.icon || 'book') as any}
        size={26}
        color="#123C7B"
      />

      <View style={styles.textContainer}>
        <Text style={styles.title}>
          {item.subject_name}
        </Text>

        <Text style={styles.subtitle}>
          {item.subtitle || 'Course'}
        </Text>
      </View>

      <Ionicons
        name="chevron-forward"
        size={20}
        color="#999"
      />
    </Pressable>
  );

  if (loading) {
    return (
      <View style={styles.loader}>
        <ActivityIndicator
          size="large"
          color="#123C7B"
        />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Text style={styles.heading}>
        📚 Free Courses
      </Text>

      <FlatList
        data={courses}
        keyExtractor={(item) =>
          item.id.toString()
        }
        renderItem={renderItem}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#fff',
  },

  loader: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },

  heading: {
    fontSize: 22,
    fontWeight: '700',
    marginBottom: 20,
    marginTop: 40,
    color: '#123C7B',
  },

  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F3F6FB',
    padding: 16,
    borderRadius: 14,
    marginBottom: 12,
  },

  textContainer: {
    flex: 1,
    marginLeft: 12,
  },

  title: {
    fontSize: 16,
    fontWeight: '700',
    color: '#123C7B',
  },

  subtitle: {
    fontSize: 13,
    color: '#555',
  },
});