# -*- Mode: cperl; coding: utf-8; cperl-indent-level: 4 -*-
# Copyright ©2004 W3C® (MIT, INRIA, Keio University),

#Last update $Date: 2007-12-21 09:35:46 $ by $Author: eric $. $Revision: 1.39 $

use strict;
my $REVISION = '$Id: Presenter.pm,v 1.39 2007-12-21 09:35:46 eric Exp $';
package W3C::Grammar::PresenterException;
@W3C::Grammar::PresenterException::ISA = qw(W3C::Util::Exception);
$W3C::Grammar::PresenterException::REVISION = '$Id: Presenter.pm,v 1.39 2007-12-21 09:35:46 eric Exp $ ';

package W3C::Grammar::Presenter;
use CGI qw/:standard/;
sub new {
    my ($proto, $yackerRevision, $legalFileName) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Buffer => '', Warnings => '', 
		YackerRevision => $yackerRevision, 
		LegalFileName => $legalFileName};
    bless ($self, $class);
    return $self;
}

# Utility functions used by subclasses

sub print {
    my ($self, @printables) = @_;
    $self->{Buffer} .= join('', @printables);
}

sub flush {$_[0]->{Buffer}}

sub error {
    my ($error) = @_;
    print "Error: $error\n";
    exit (1);
}

package W3C::Grammar::TextPresenter;
@W3C::Grammar::TextPresenter::ISA = qw(W3C::Grammar::Presenter);
use POSIX qw(ceil);
use CGI qw/:standard/;
use W3C::Util::Exception;

package W3C::Grammar::XHTMLPresenter;
@W3C::Grammar::XHTMLPresenter::ISA = qw(W3C::Grammar::Presenter);
use POSIX qw(ceil);
use utf8;
use CGI qw/:standard/;
use W3C::Util::Exception;

sub ErrorHeader {
    my ($self, $code, $text, $ct) = @_;
    my $status = "$code $text";
    $self->print("Status: $status\nContent-Type: $ct\n\n");
}

sub xmlEncode {
    my ($d, $a) = @_;
    $a =~ s/\&/\&amp;/g;
    $a =~ s/\"/\&quot;/g;
    $a =~ s/\</\&lt;/g;
    $a =~ s/\>/\&gt;/g;
    return $a;
}

sub getContentType {'text/html'}

sub printDocumentHeader {
    my ($self, $title, ) = @_;
    $self->ErrorHeader(200, 'OK', 'text/html; charset=utf-8');
    $self->print("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">
  <head>
    <meta name=\"generator\" content=\"$0\" />
    <title>$title</title>
    <link rel=\"stylesheet\" href=\"http://www.w3.org/StyleSheets/base.css\" type=\"text/css\" />
    <style type=\"text/css\">
       h1 { text-align:center;}
       .result { background: #bfb; color: #black; border: 1px solid black; }
       p.result { font-family: monospace; font-size: 88%; }
       .error { color: red }
       .trace { margin: 40px; font-size: 88%; background: #eee; border: 1px solid black; }

.grammar { text-align: left ; vertical-align: top ; 
           font-family: monospace ; font-size:10pt ;}
.token { color: #3f3f5f; font-size: 88%; /* text-transform: uppercase; */ }
.production { font-family: monospace; font-style: italic; }
.term { color: #3f3f5f; font-size: 88%;  }
a.grammarRef:link { text-decoration: none; }
a.grammarRef:visited { text-decoration: none; }
a.grammarRef:hover { text-decoration: none; }
a.grammarRef:active { text-decoration: none; }
.comment { color: red; }

    </style>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  </head>
  <body>
    <div class=\"navbar\">
      <a href=\"http://www.w3.org/\"><img src=\"http://www.w3.org/Icons/WWW/w3c_home\"alt=\"W3C\" style=\"border:none; \" /></a> | 
      <a href=\"http://www.w3.org/1999/02/26-modules/User/Yacker\">learn about yacker</a>
    </div>
    <h1>$title</h1>\n$self->{Warnings}");
}

sub printDocumentFooter {
    my ($self) = @_;
    $self->print("    <hr />
    <address><a href=\"http://www.w3.org/People/Eric/\">Eric Prud'hommeaux</a>
      <tt><a href=\"mailto:eric+yacker\@w3.org\">&lt;eric+yacker\@w3.org&gt;</a></tt><br />
$self->{YackerRevision}<br />
$REVISION</address>
    <p>
      <a href=\"http://validator.w3.org/check?uri=referer\"><img
          src=\"http://www.w3.org/Icons/valid-xhtml10\"
          alt=\"Valid XHTML 1.0!\" height=\"31\" width=\"88\" /></a>
    </p>
  </body>
</html>
");
}

# ==================== dynamic HTML documents ====================
sub promptCreateGrammar {
    my ($self, $handler, $nextAction, $langs, $defaultName, $defaultReplace, $defaultLang, $defaultBNF) = @_;
    $self->printDocumentHeader('yacker: Create a grammar');

    my $checkedStr = $defaultReplace ? ' checked="checked"' : '';
    $defaultBNF = $self->xmlEncode($defaultBNF);
    my $langOpts = '';
    foreach my $lang (@$langs) {
	my ($value, $text) = @$lang;
	my $selected = $value eq $defaultLang ? ' selected="selected"' : '';
	$langOpts .= "            <option value=\"$value\"$selected>$text</option>\n";
    }
    $self->print("
    <p>Input a grammar to test:</p>
    <form id=\"grammar\" name=\"grammar\" action=\"\" method=\"post\">
      <ol>
        <li>Grammar name: <input name=\"name\" type=\"text\" value=\"$defaultName\"/> Overwrite existing grammar: <input type=\"checkbox\" name=\"replace\" value=\"1\"$checkedStr/> (Please be polite about changing grammars.) </li>
        <li>Grammar BNF: <textarea name=\"bnf\" rows=\"13\" cols=\"100\">$defaultBNF</textarea> <input type=\"button\" value=\"clear BNF\" onclick=\"document.grammar.bnf.value=''\" /></li>
        <li>generate grammar in <select name=\"lang\">
            $langOpts</select>.</li>
        <li>generate <select name=\"generate\"><option value=\"descriptive\">descriptive</option><option value=\"short\">terse</option></select> names.</li>
        <li><input type=\"submit\" name=\"action\" value=\"$nextAction\" /></li>
      </ol>
    </form>
    <p>or <a href=\"?action=list+grammars\">list existing parsers</a>.</p>
");
    $self->printDocumentFooter();
}

sub listGrammars {
    my ($self, $uploads) = @_;
    my $errors;
    my $ls = $self->directoryListing('yacker', "$uploads", 'perl');

    $self->printDocumentHeader("yacker grammars");
    $self->print("
    <p>$ls</p>\n");
    $self->printDocumentFooter();
}

sub _markupFlavorBuffer { # static
    my ($flavorBuffer) = @_;
    my $markup = '';
    my $errors = 0;
    foreach my $entry ($flavorBuffer->contents()) {
	my $classStr;
	my $data = $entry->getData();
	if (length($data) > 0) {
	    my $flavor = $entry->getFlavor();
	    if ($flavor eq 'stdout') {
		$classStr = '';
	    } elsif ($flavor eq 'stderr') {
		$classStr = 'error';
		$errors++;
	    } else {
		$classStr = 'unknown';
	    }
	    my $text = &xmlEncode(undef, $data);
	    $markup .= "<span class=\"$classStr\">$text</span>";
	}
    }
    return ($markup, $errors);
}

sub creationResults {
    my ($self, $handler, $new, $uploads, $name, $lang, $results, $pResultsStr, $html) = @_;
    my $actionStr = $new ? 'creat' : 'updat';
    my $errors;
    ($$pResultsStr, $errors) = &_markupFlavorBuffer($results);
    my $ls = $self->directoryListing('yacker', "$uploads/$name", $lang);

    $self->printDocumentHeader($errors ? "yacker: error ${actionStr}ing $name" : "yacker: ${actionStr}ed $name");
    $self->print("
    <p>${actionStr}ed <a href=\"yacker/$uploads/$name/bnf?markup=html\">$name</a>. See $ls</p>
    <p>Compilation Results:</p>
    <pre class=\"result\">$$pResultsStr</pre>\n");
    $self->print("<p><a href=\"yacker/$uploads/$name?lang=$lang\">Try out this parser.</a></p>\n");
    $self->print("<p><a href=\"yacker?name=$name&amp;replace=1&amp;lang=$lang\">Edit this grammar.</a></p>\n");
    $self->print($html);
    $self->printDocumentFooter();
}

sub promptValidateText {
    my ($self, $handler, $actions, $generate, $uploads, $name, $lang, $text, $results, $error, $traceHtml, $html, $resultsMarkup, $seed, $limit, $asciiWeight) = @_;
    $self->printDocumentHeader($results || $error ? "yacker: $name validation results" : "yacker: $name validator");

    my $checkedStr = $html ? ' checked="checked"' : '';
    my $grammarHiddenField = $html ? 
      "<input name=\"markup\" type=\"hidden\" value=\"html\" />\n" : 
	"";
    my $grammarExpandLinkExcerpt = $html ? 
      "&amp;markup=html" : 
	"";
    my $changeGrammarExpandLinkExcerpt = $html ? 
      "" : 
	"&amp;markup=html";
    my $changeGrammarExpandLinkText = $html ? 
      "Hide grammar." : 
	"Show grammar.";
    my $ls = $self->directoryListing('../../yacker', "$uploads/$name", $lang);
    my $t2 = $text;
    &utf8::encode($t2);
    $text = $self->xmlEncode($t2);
    if ($results) {
	&utf8::encode($results);
	$results = "    <p>Validation results:</p>\n<blockquote><pre class=\"result\">".$self->xmlEncode($results)."</pre></blockquote>\n";
    }
    if ($error) {
	# already XML-encoded
	$t2 = $error;
	&utf8::encode($t2);
	$error = $self->xmlEncode($t2);
	$error = "    <p>Validation errors:</p>\n<pre class=\"results error\">".$error."</pre>\n";
    }
    if ($traceHtml) {
	$traceHtml = "    <p>Trace:</p>\n<dl class=\"results trace\">".$traceHtml."</dl>\n";

    }
    my $actionsStr = join(' ', map {"<input type=\"submit\" name=\"action\" value=\"$_\" />"} @$actions);
    $self->print("
    <p>Validating against the <a href=\"$name/bnf?markup=html\">$name</a> grammar. See</p>
$ls
    $error$results$traceHtml<p>Input some text to test:</p>
    <form id=\"language\" name=\"language\" action=\"\" method=\"get\">
      <p>$grammarHiddenField<input name=\"lang\" type=\"hidden\" value=\"$lang\" /></p>
      <ol>
        <li><textarea name=\"text\" rows=\"13\" cols=\"100\">$text</textarea> <input type=\"button\" value=\"clear text\" onclick=\"document.language.text.value=''\" /></li>
        <li>$actionsStr</li>
      </ol>
    </form>\n");
    $self->print("<pre class=\"result\">$resultsMarkup</pre>\n");
    $self->print("    <p><a href=\"../../yacker?name=$name&amp;replace=1&amp;lang=$lang\">Edit this grammar.</a></p>\n");
    $self->print("    <!-- <a href=\"$name?lang=$lang${grammarExpandLinkExcerpt}&amp;action=$generate&amp;seed=0&amp;limit=50\">Generate Text.</a> or -->
    <form id=\"genText\" action=\"\" method=\"get\">
      <p><input type=\"submit\" name=\"action\" value=\"generate text\" />
      with seed <input name=\"seed\" type=\"text\" size=\"3\" value=\"$seed\"/>.
      with limit <input name=\"limit\" type=\"text\" size=\"3\" value=\"$limit\"/>.
      and ascii weight <input name=\"asciiWeight\" type=\"text\" size=\"3\" value=\"$asciiWeight\"/> (0-100).
      <input name=\"lang\" type=\"hidden\" value=\"$lang\" />
    </p></form>\n");
    $self->print("    <p><a href=\"$name?lang=$lang$changeGrammarExpandLinkExcerpt\">$changeGrammarExpandLinkText</a></p>\n$html");
    $self->printDocumentFooter();
}

sub renderMarkup {
    my ($self, $name, $lang, $markup, $markedup) = @_;
    $self->printDocumentHeader("$name as $markup");
    $self->print($markedup);
    $self->print("<p><a href=\"../$name?lang=$lang\">Try out this parser.</a></p>\n");
    $self->print("<p><a href=\"../../../yacker?name=$name&amp;replace=1&amp;lang=$lang\">Edit this grammar.</a></p>\n");
    $self->printDocumentFooter();
}

# ==================== support functions ====================

sub directoryListing {
    my ($self, $base, $dir, $lang) = @_;
    if (!opendir(DIR, $dir)) {
	#$self->ErrorHeader(404, "File not found", 'text/plain');
	$self->print("unable to open directory \"$dir\"\n");
	print $self->flush();
	exit (1);
    }
    my @ret;
    foreach my $file (sort readdir(DIR)) {
	if ($file =~ m/^$self->{LegalFileName}$/) {
	    push (@ret, $file);
	}
    }
    return "    <ul>\n".join('', map {"      <li><a href=\"$base/$dir/$_?lang=$lang\">$_</a></li>\n"} @ret)."    </ul>\n";
}

sub showFile {
    my ($self, $fileName) = @_;
    if (open(H, $fileName)) {
	local $/ = undef;
	$self->ErrorHeader(200, "OK", 'text/plain');
	$self->print(<H>);
	close(H);
    } else {
	$self->ErrorHeader(404, "File not found", 'text/plain');
	print "unable to open file \"$fileName\"\n";
	exit (1);
    }
}

sub print_Exception {
    my ($self, $exception) = @_;
    my $m = $self->xmlEncode($exception->getMessage);
    $self->print("<p><strong>$m</strong></p>\n");
}

sub warning {
    my ($self, $message) = @_;
    # $message = $self->xmlEncode($message);
    $self->{Warnings} .= "<div class=\"warning\"><strong>Warning</strong>: $message</div>\n";
}

sub error {
    my ($self, $error) = @_;
    print $self->ErrorHeader(501, 'Vague Unpleasentness', 'text/html');
    print "<html><head><title>Error</title></head><body>\n";
    print "<h1>Error</h1>\n<pre>$error</pre>\n";
    print "</body></html>\n";
    exit (1);
}

1;

