\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \minor
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\repeat volta 2 {
				g8 c c c bes aes g r |
			}
		}
}

text =  \lyricmode {
   Wa -- he gu -- ru sa -- ta -- nam
}

twochords = \chordmode { c2 bes:m | }

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
      \twochords
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { }
}