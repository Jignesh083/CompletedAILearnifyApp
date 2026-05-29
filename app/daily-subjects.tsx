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

const BASE_URL = 'https://ailearnifyapp-tbrt.onrender.com';

export default function DailySubjects() {

  const router = useRouter();

  const [subjects, setSubjects] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSubjects();
  }, []);

  const fetchSubjects = async () => {

    try {

      console.log('FETCHING SUBJECTS...');

      const response = await fetch(
        `${BASE_URL}/subjects`
      );

      console.log('STATUS:', response.status);

      const data = await response.json();

      console.log('API DATA:', data);

      // force rerender
      setSubjects([...data]);

    } catch (error) {

      console.log('SUBJECT FETCH ERROR:', error);

    } finally {

      setLoading(false);

    }
  };

  const renderItem = ({ item }) => {

    console.log('RENDER ITEM:', item);

    return (
      <Pressable
        style={styles.card}
        onPress={() =>
          router.push({
            pathname: '/daily-quiz',
            params: {
              subject: item.subject_key,
              subjectId: item.id,
            },
          })
        }
      >
        <Text style={styles.cardText}>
          {item.subject_name}
        </Text>
      </Pressable>
    );
  };

  if (loading) {

    return (
      <View style={styles.loaderContainer}>
        <ActivityIndicator size="large" color="#123C7B" />

        <Text style={{ marginTop: 20 }}>
          Loading Subjects...
        </Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>

      <Text style={styles.title}>
        Select Subject
      </Text>

      {/* DEBUG TEXT */}
      <Text
        style={{
          fontSize: 22,
          color: 'red',
          marginBottom: 20,
          fontWeight: 'bold',
        }}
      >
        DYNAMIC SUBJECT LOADING ✅
      </Text>

      <FlatList
        data={[...subjects]}
        keyExtractor={(item, index) =>
          item.id
            ? item.id.toString()
            : index.toString()
        }
        renderItem={renderItem}
        showsVerticalScrollIndicator={false}
        ListEmptyComponent={() => (
          <Text
            style={{
              fontSize: 18,
              color: 'red',
              marginTop: 40,
            }}
          >
            No Subjects Found
          </Text>
        )}
      />

    </View>
  );
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#F5F7FB',
  },

  loaderContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },

  title: {
    marginTop: 30,
    fontSize: 24,
    fontWeight: '800',
    marginBottom: 20,
    color: '#123C7B',
    letterSpacing: 0.5,
  },

  card: {
    padding: 18,
    backgroundColor: '#ffffff',
    borderRadius: 16,
    marginBottom: 14,

    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 3,

    borderLeftWidth: 4,
    borderLeftColor: '#123C7B',
  },

  cardText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#222',
  },

});