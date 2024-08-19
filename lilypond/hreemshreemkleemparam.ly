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
	Hrīṃ Shrīṃ Klīṃ Pa -- ram -- Ī -- śva -- ri Svā -- hā
	Hrīṃ Shrīṃ Klīṃ Pa -- ram Ī -- śva -- ri Svā -- hā
}

\score {
      <<
    \new Staff  {
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