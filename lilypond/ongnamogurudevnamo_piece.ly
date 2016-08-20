\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
			\clef treble
			\key c \major
			\time 4/4
			\new Voice = "words" {
				r4 d8 d r4 d8 d |
			}
		}
		
text =  \lyricmode { gu -- ru gu -- ru }
\score {
<<
	\new ChordNames {
		\set chordChang = ##t
	}
	\new Staff \with { \magnifyStaff #5/7 } {
		\new Voice = "one" { \melody }
	}
	\new Lyrics \lyricsto "words" \text
>>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}