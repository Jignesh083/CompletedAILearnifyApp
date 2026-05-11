import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { FlatList, Image, Pressable, StyleSheet, Text, View } from 'react-native';

const PAID_DSA_TOPICS = [
  {
    id: '1',
    title: 'Advanced Recursion & Backtracking',
    subtitle: 'Subsets, Permutations, N-Queen',
    icon: 'git-branch-outline',
  },
  {
    id: '2',
    title: 'Linked List (Deep)',
    subtitle: 'Reverse, Cycle, Merge',
    icon: 'link-outline',
  },
  {
    id: '3',
    title: 'Stack & Queue (Advanced)',
    subtitle: 'LRU, NGE, Sliding Window',
    icon: 'layers-outline',
  },
  {
    id: '4',
    title: 'Trees',
    subtitle: 'BT, BST, Traversals, LCA',
    icon: 'leaf-outline',
  },
  {
    id: '5',
    title: 'Graphs',
    subtitle: 'BFS, DFS, Dijkstra',
    icon: 'share-social-outline',
  },
  {
    id: '6',
    title: 'Dynamic Programming',
    subtitle: 'Knapsack, LIS, LCS',
    icon: 'flash-outline',
  },
];

export default function PaidDSAScreen() {
  const router = useRouter();

  const renderItem = ({ item }: any) => (
    <Pressable
      style={styles.card}
      onPress={() =>
        router.push({
          pathname: '/paid/[id]',
          params: {
            id: item.id,
            title: item.title,
          },
        })
      }
    >
      <Ionicons name={item.icon} size={24} color="#9B1C1C" />

      <View style={{ flex: 1, marginLeft: 12 }}>
        <Text style={styles.cardTitle}>{item.title}</Text>
        <Text style={styles.cardSubtitle}>{item.subtitle}</Text>
      </View>

      <Ionicons name="lock-closed-outline" size={18} color="#9B1C1C" />
    </Pressable>
  );

  return (
    <View style={styles.container}>
      
      <View style={styles.header}>
        <Image
          source={require('../assets/images/logo.png')}
          style={styles.logo}
        />
        <Text style={styles.companyName}>AILearnify</Text>
      </View>

      <Text style={styles.heading}>🔥 Paid DSA Courses</Text>

      <FlatList
        data={PAID_DSA_TOPICS}
        keyExtractor={(item) => item.id}
        renderItem={renderItem}
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