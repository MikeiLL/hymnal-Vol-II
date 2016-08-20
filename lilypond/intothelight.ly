\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key g \major
  \time 6/8
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			b8 b b a4 g8 | b4 b8 a4. | a8 a a a( g e | d2.) |
			d8 d d e4 e8 | g4 g8 a4. | \time 3/8 <b d>8 <b d> <b d> | \time 6/8 <b d>( <c e>4.)~ <c e>4 |
			a8 a a a g e | d2.~ | d~ | d |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	In -- to the light. In -- | to the light. | In -- to the light__ |
	In -- to the light. In -- | to the light. | In -- to the light__ |
	In -- to the light__ |
}


bassline = \relative c {
	\clef bass
	g8. d' g, d' |
	g,8. d' g, d' |
	g,8. d' g, d' |
	fis, a fis d |
	c g' c, g' |
	c, g' c, g' |
	c, g' | c a e a |
	g fis e fis |
	g8. d' g, d' |
	g,8. d' g, d' |
	g,8. d' c b |
}

\score {
  <<
    \new GrandStaff <<
    	\new Staff = "upper" \melody
    	\new Lyrics \lyricsto "words" \text
    	\new Staff = "lower" \bassline
  	>>
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}