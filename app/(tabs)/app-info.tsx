import { Image, StyleSheet, Text, View } from 'react-native';

export default function AppInfoScreen() {
  return (
    <View style={styles.container}>

      {/* APP LOGO */}
      <Image 
        source={require('../../assets/images/logo.png')} 
        style={styles.appLogo}
              />

      {/* APP NAME */}
      <Text style={styles.title}>AI Learnify</Text>
      <Text style={styles.subtitle}>Smart Learning Made Simple</Text>

      {/* DESCRIPTION */}
      <View style={styles.card}>
        <Text style={styles.desc}>
          Learn Data Structures, Algorithms, and Programming concepts with
          structured roadmaps, quizzes, and mock tests.
        </Text>
      </View>

      {/* FEATURES */}
      <Text style={styles.section}>✨ Features</Text>

      <View style={styles.featureCard}>
        <Text style={styles.item}>📘 Roadmap-based learning</Text>
        <Text style={styles.item}>🧠 Practice quizzes</Text>
        <Text style={styles.item}>📝 Mock tests (coming soon)</Text>
      </View>

      {/* COMPANY SECTION */}
      <View style={styles.companyBox}>
        <Text style={styles.companyText}>Powered by</Text>

        <Image 
          source={require('../../assets/images/logoCompany.png')} 
          style={styles.companyLogo}
        />

        <Text style={styles.companyName}>AICORE SYSTEM</Text>
      </View>

      {/* FOOTER */}
      <Text style={styles.footer}>Version 1.0</Text>

    </View>
  );
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    backgroundColor: '#F5F7FB',
    padding: 20,
    alignItems: 'center',
  },

  /* APP LOGO */
  appLogo: {
    width: 190,
    height: 190,
    resizeMode: 'contain',
    marginTop: 40,
    marginBottom: 10,
  },

  title: {
    fontSize: 26,
    fontWeight: '900',
    color: '#123C7B',
  },

  subtitle: {
    fontSize: 14,
    color: '#666',
    marginBottom: 20,
  },

  /* CARD */
  card: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 16,
    marginBottom: 20,
    width: '100%',
    elevation: 3,
  },

  desc: {
    fontSize: 14,
    color: '#333',
    textAlign: 'center',
  },

  section: {
    fontSize: 18,
    fontWeight: '800',
    marginBottom: 10,
    color: '#123C7B',
    alignSelf: 'flex-start',
  },

  featureCard: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 16,
    marginBottom: 20,
    width: '100%',
    elevation: 3,
  },

  item: {
    fontSize: 14,
    marginBottom: 8,
    color: '#333',
  },

  /* COMPANY */
  companyBox: {
    marginTop: 6,
    alignItems: 'center'
  },

  companyText: {
    fontSize: 12,
    color: '#888',
  },

  companyLogo: {
    width: 30,
    height: 30,
    resizeMode: 'contain',
    marginVertical: 5,
  },

  companyName: {
    fontSize: 13,
    fontWeight: '600',
    color: '#444',
  },

  footer: {
    marginTop: 20,
    fontSize: 12,
    color: '#aaa',
  },

});