\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key d \major
  \time 6/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
  \repeat volta 2 {
		\new Voice = "words" {
				b4 e g fis e c | b e b' a g fis |
				b, e g fis8 e d c c b |
				e2. a, | g fis |
			}
		}
}

twochords = \chordmode { 
	e2.:m a:dim | e:m a:7 |
	e:m a:dim |
	e:m a:dim |
	e:m a |
 }

harmonies = {
	\twochords
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}