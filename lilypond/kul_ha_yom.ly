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
				<ees g> <ees aes> <ees g> <ees aes> <ees g>( <d f>) <c ees>4| <c ees>1 |
				<bes f'>4 <bes f'>8 <c ees> <d f> <d f> <d f> <ees ees> | <d f>( <c g'>) <c g'>2 <c ees>8 <d f>
			}
		}
}

text =  \lyricmode {
   Kul ha |
   yom vi khul ha lai__ la | om |
   Om kul ha yom vi khul ha | lai__ la Kul ha |
}

twochords = \chordmode { 
	\set noChordSymbol = "" 
	r4  |
	c1:m | c:m | bes | c:m |
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
      \twochords
    }
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