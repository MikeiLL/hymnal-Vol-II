\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key b \major
  \time 9/8
  \new Voice = "words" {
		\repeat volta 2 {
			b4. c dis | fis8 fis~ fis4. g8 fis fis e |  dis1 r8 |
			b4. c dis | e8 e~ e4. fis8 e dis c | dis1 r8 |
		}
	}
}

text =  \lyricmode {
	Hreem Shreem Kleem Pa - ram E -- shwa -- ra Swa -- ha
	Hreem Shreem Kleem Pa - ram E -- shwa -- ra Swa -- ha
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
    \midi { 
  	\tempo 4 = 125
  }
}