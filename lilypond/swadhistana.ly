\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key b \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		 b2 b | c8( dis4) c8 dis4 c |
		 b2 b | c8( dis e) fis dis4 c |
		}
	}
}

text =  \lyricmode {
	Vam Vam Swa__ -- dhi -- sta -- na
	Vam Vam Swa__ -- dhi -- sta -- na
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
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