\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key g \minor
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			d4 d8 d c d4. | d4 \times 2/3 { ees8 ees4 } d4 r |
			d4 d8 d c d4. | d4 \times 2/3 { ees8 ees4 } d4 r |
			d8 d4 c8 d4. c8 | d4 \times 2/3 { ees8 ees4 } d4 r |
			d8 d4 c8 d4. c8 | d4 \times 2/3 { ees8 ees4 } d4 r |
			\grace c16 c4 c d ees8. d16 | d4 \times 2/3 { ees8 ees4 } d4 r |
			\grace c16 c4 c d ees8. d16 | d4 \times 2/3 { ees8 ees4 } d4 r |
		}
}

text =  \lyricmode {
	Om a -- sa -- to ma | sat ga -- ma -- ya |
	Om a -- sa -- to ma | sat ga -- ma -- ya |
	ta -- ma -- so ma jyo -- | tir ga -- ma -- ya |
	ta -- ma -- so ma jyo -- | tir ga -- ma -- ya |
	m'dit -- yir ma a -- mri -- | tam ga -- ma -- ya |
	m'dit -- yir ma a -- mri -- | tam ga -- ma -- ya |
}

harmonies = \chordmode {
	g1:m | g:m | g:m | g:m |
	g:m | g:m | g:m | g:m |
	d:m | g:m | d:m | g:m |
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
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}