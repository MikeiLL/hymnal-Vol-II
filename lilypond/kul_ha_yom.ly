\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key bes \major
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\partial 4 <c ees>8 <d f> |
			\repeat volta 2 {
				<ees g> <ees g> <ees g> <ees g> <ees g>( <d f>) <c ees>4| <c ees>1 |
				<bes d>4 <bes d>8 <c ees> <d f> <d f> <d f> <ees g> | <d f>( <c ees>) <c ees>2 <c ees>8 <d f>
			}
		}
}

text =  \lyricmode {
   Kul ha |
   yom vi khul ha lai__ la | om |
   Om kul ha yom vi khul ha | lai__ la Kul ha |
}

twochords = \chordmode { 
	c4:m  |
	c1:m | c:m | bes:m | c:m |
}

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