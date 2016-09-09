\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \major
  \time 7/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 4 g4(
		\repeat volta 2 {
			c2.) g' a8 <a c> | g2 e8 g~ g2. a8 <a c> | 
			g2 e8 g~ g2. e4 | \time 4/4 d2. g,4 |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om__ Śrīṁ La -- kṣmī yea Sva -- ha
	La -- kṣmī yea Sva -- ha
	La -- kṣmī__ Om__
}

harmonies = \chordmode {
\set noChordSymbol = "" 
\partial 4 r4
	c2. c f4/c | c2. c f4/c |
	c2. c c4 | f1/c
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