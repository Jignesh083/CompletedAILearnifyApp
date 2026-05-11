import Svg, {
  Circle,
  Defs,
  Line,
  LinearGradient,
  Path,
  RadialGradient,
  Stop,
} from 'react-native-svg';

const AILearnifyLogo = ({ size = 200 }) => {
  return (
    <Svg width={size} height={size} viewBox="0 0 300 300">

      <Defs>
        <LinearGradient id="hexGradient1" x1="0%" y1="0%" x2="100%" y2="100%">
          <Stop offset="0%" stopColor="#60A5FA" />
          <Stop offset="50%" stopColor="#A78BFA" />
          <Stop offset="100%" stopColor="#EC4899" />
        </LinearGradient>

        <LinearGradient id="hexGradient2" x1="0%" y1="0%" x2="100%" y2="0%">
          <Stop offset="0%" stopColor="#818CF8" />
          <Stop offset="100%" stopColor="#06B6D4" />
        </LinearGradient>

        <RadialGradient id="centerGradient" cx="150" cy="130" r="25">
          <Stop offset="0%" stopColor="#6366F1" />
          <Stop offset="100%" stopColor="#3B82F6" />
        </RadialGradient>
      </Defs>

      <Path
        d="M150 50 L220 90 L220 170 L150 210 L80 170 L80 90 Z"
        stroke="url(#hexGradient2)"
        strokeWidth="4"
        fill="none"
        opacity="0.4"
      />

      <Path
        d="M150 75 L200 102.5 L200 157.5 L150 185 L100 157.5 L100 102.5 Z"
        stroke="url(#hexGradient1)"
        strokeWidth="3.5"
        fill="none"
        opacity="0.5"
      />

      <Circle
        cx="150"
        cy="130"
        r="25"
        fill="url(#centerGradient)"
      />

      <Circle cx="150" cy="85" r="7" fill="#3B82F6" opacity="0.8" />
      <Circle cx="120" cy="100" r="6" fill="#818CF8" opacity="0.7" />
      <Circle cx="180" cy="100" r="6" fill="#818CF8" opacity="0.7" />
      <Circle cx="120" cy="160" r="6" fill="#A78BFA" opacity="0.7" />
      <Circle cx="180" cy="160" r="6" fill="#A78BFA" opacity="0.7" />
      <Circle cx="150" cy="175" r="7" fill="#EC4899" opacity="0.8" />

      <Line x1="150" y1="85" x2="150" y2="105" stroke="#3B82F6" strokeWidth="2" opacity="0.3" />
      <Line x1="120" y1="100" x2="130" y2="115" stroke="#818CF8" strokeWidth="2" opacity="0.3" />
      <Line x1="180" y1="100" x2="170" y2="115" stroke="#818CF8" strokeWidth="2" opacity="0.3" />
      <Line x1="120" y1="160" x2="130" y2="145" stroke="#A78BFA" strokeWidth="2" opacity="0.3" />
      <Line x1="180" y1="160" x2="170" y2="145" stroke="#A78BFA" strokeWidth="2" opacity="0.3" />
      <Line x1="150" y1="175" x2="150" y2="155" stroke="#EC4899" strokeWidth="2" opacity="0.3" />

    </Svg>
  );
};

export default AILearnifyLogo;