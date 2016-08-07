\version "2.19.45"

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\repeat volta 2 {
				e2 f | g8 r g g aes4 g | e2 f | g8 r g g aes4 g |
				g2 f | e4 des8 des des r c4 | g'2 f | e4 des8 des des r c4 |
			}
		}
}

text =  \lyricmode {
   O -- pen | up a -- na -- ha -- ta |  O -- pen | up a -- na -- ha -- ta |
   Yum Yum | Yum a -- na -- ha -- ta | Yum Yum | Yum a -- na -- ha -- ta |
}

\score {
  <<
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