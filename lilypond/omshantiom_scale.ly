\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
	\override Staff.TimeSignature #'stencil = ##f 
  \clef treble
  \time 8/4
  \key c \major
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		 c4 des ees fis g a bes c
	}
}

text =  \lyricmode {
	
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    	\new Lyrics \lyricsto "words" \text
  >>
  \layout { 
  \override Score.BarLine.break-visibility = ##(#f #t #t)
   #(layout-set-staff-size 16)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}