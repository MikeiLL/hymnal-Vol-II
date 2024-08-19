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
				e2 f | g8 r g aes aes4 g | g2 f | e4 des8 des des r c4 |
			}
			r4 c'8 des des r c4 | r4 c,8 des des r c4 | 
		}
}

text =  \lyricmode {
<<
 {
 \set stanza = #"" 
   O -- pen | up a -- nā -- ha -- ta | Yum Yum | Yum a -- nā -- ha -- ta |
  }
 \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   Sof -- ten | up a -- nā -- ha -- ta | Yum Yum | Yum a -- nā -- ha -- ta |
  }
  \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   Ligh -- ten | up a -- nā -- ha -- ta | Yum Yum | Yum a -- nā -- ha -- ta |
  }
>>
	a -- nā -- ha -- ta | a -- nā -- ha -- ta
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
  \midi { }
}