\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key f \minor
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			f2.~ | f2 ees4 |
			f4 ees f | ees2 ees4 |
			f f g | aes2 ees4 | % being oh lead from
			f ees f | ees f8 ees f4 |
			ees f g | aes2 ees4 |
			f2 f4 | ees f ees | % death me to eternal
			f f g4 | aes2 bes4 |
			c2. | c | c~ | c
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om. From non- -- be -- ing me to
	be -- ing oh lead.
	From dark -- ness me to e -- ver -- las -- ting 
	light, oh lead.
	From death me to e -- ter -- nal
	life, oh lead. Om peace peace peace.
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
    }
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