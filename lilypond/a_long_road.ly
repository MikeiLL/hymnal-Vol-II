\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
	\relative c,
  \clef treble
  \key d \minor
  \time 7/8 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\partial 8 a8 |	
			\repeat volta 2 {
				d4. f a,8 | d4. f c8 | d4. f e8 | 
				\time 4/4 e( d8)~ d2 r8 a |
				\time 7/8 d4. f c8 | d4. f e8 | 
				\time 4/4 e( d)~ d2 r8 a |
			}
		}
}

text =  \lyricmode {
	The | road is a | long road a | long road for |us. The
	road breathes. The | road is a -- | live. The |
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