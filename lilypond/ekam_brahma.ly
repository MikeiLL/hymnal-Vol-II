\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key d \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\repeat volta 2 {
				d8 r d r d d ees d | d r d r d d ees d |
				c r c r c c d ees | d8 r d r d d ees fis~ | 
				fis1( | g4 a g8 fis ees4) |
			}
		}
}

text =  \lyricmode {
	Sat Chit E -- kam Brah -- ma | Sat Chit E -- kam Brah -- ma |
	Sat Chit E -- kam Brah -- ma | Sat Chit E -- kam Brah -- ma__ |
	| | 
}

harmonies = \chordmode { 
	d1 | d | c:min | d | d | c:min |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
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