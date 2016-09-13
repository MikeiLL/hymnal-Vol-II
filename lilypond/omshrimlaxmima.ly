\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 4 g4(
		\repeat volta 2 {
			c1) | g'2. g8 <g c> | a2. e8 g~ | g2. g8 <g c> | 
			a2. e8 g~ | g2. e8 d | d2. g,4 |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om__ Śrīṁ La -- kṣmī yea Sva -- ha
	La -- kṣmī yea Sva -- ha
	La -- kṣmī yea Om__
}

harmonies = \chordmode {
\set noChordSymbol = "" 
\partial 4 r4
	c1 | c | f/c | c |
	f/c | c | f1/c |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}