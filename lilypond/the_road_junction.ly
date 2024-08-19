\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key d \minor
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\partial 8 c8 |	
			\repeat volta 2 {
				d4 d f4. c8 | d d4 f2 c8 |
				d4 d f4. c8 | d d4 d r4 c8 |
			}
		}
}

text =  \lyricmode {
	The | road junc -- | tion, the | road junc -- tion. The
	road junc -- | tion, the | road junc -- tion. The
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