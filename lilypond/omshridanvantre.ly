\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key f \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 8 e8( 
		\repeat volta 2 {
			f2) a~ | a g4 g4 | 
			f2 e4 d | c2( d4.) e8( |
			f4.) e8( f4.) e8
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Aom Śrī
	Dhan -- van -- tre Na -- ma -- ha__ 
	Aom Aom A
}

harmonies = \chordmode {
\set noChordSymbol = "" 
\partial 4 r4
	f
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