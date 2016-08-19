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
			\repeat volta 2 {
				e2 f | g8 r g g aes4 g | g2 f | e4 des8 des des r c4 |
			}
			r4 c'8 c des r c4 | r4 c,8 c des r c4 | 
		}
}

text =  \lyricmode {
<<
 {
 \set stanza = #"" 
   O -- pen | up a -- na -- ha -- ta | Yum Yum | Yum a -- na -- ha -- ta |
  }
 \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   Sof -- ten | up a -- na -- ha -- ta | Yum Yum | Yum a -- na -- ha -- ta |
  }
  \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   Ligh -- ten | up a -- na -- ha -- ta | Yum Yum | Yum a -- na -- ha -- ta |
  }
>>
	a -- na -- ha -- ta | a -- na -- ha -- ta
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