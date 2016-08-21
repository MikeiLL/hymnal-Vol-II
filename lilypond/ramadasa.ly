\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key g \major
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		 b2. | a | g | a |
		 e | a | g | g4 r2 |
		}
	}
}

text =  \lyricmode {
	Ra Ma Da Sa
	Sa Say So Hung
}

harmonies = \chordmode {
\set noChordSymbol = "" 
 e2.:m | e:m | e:m | e:m |
 a:m | a:m | g | b:7 |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    	\new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}