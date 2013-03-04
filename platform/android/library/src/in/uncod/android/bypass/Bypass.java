package in.uncod.android.bypass;

import in.uncod.android.bypass.Element.Type;
import android.graphics.Typeface;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.TextUtils;
import android.text.style.BulletSpan;
import android.text.style.RelativeSizeSpan;
import android.text.style.StyleSpan;
import android.text.style.URLSpan;

public class Bypass {
	static {
		System.loadLibrary("bypass");
	}

	private static final float[] HEADER_SIZES = {
	        1.5f, 1.4f, 1.3f, 1.2f, 1.1f, 1f,
	};
	
	public CharSequence markdownToSpannable(String markdown) {
		Document document = processMarkdown(markdown);
		
		CharSequence[] spans = new CharSequence[document.getElementCount()];
		for (int i=0; i<document.getElementCount(); i++) {
			spans[i] = recurseElement(document.getElement(i));
		}
		
		return TextUtils.concat(spans);
	}
	
	private native Document processMarkdown(String markdown);
	
	private CharSequence recurseElement(Element element) {
		
		CharSequence[] spans = new CharSequence[element.size()];
		for (int i=0; i<element.size(); i++) {
			spans[i] = recurseElement(element.children[i]);
		}
		
		CharSequence concat = TextUtils.concat(spans);
		
		SpannableStringBuilder builder = new SpannableStringBuilder();
		builder.append(element.getText());
		builder.append(concat);
		if(element.isBlockElement() && element.type != Type.LIST_ITEM) {
			builder.append("\n");
		}
		
		if (element.getType() == Type.HEADER) {
			String levelStr = element.getAttribute("level");
			int level = Integer.parseInt(levelStr);
			builder.setSpan(new RelativeSizeSpan(HEADER_SIZES[level]),
					0, builder.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            builder.setSpan(new StyleSpan(Typeface.BOLD),
            		0, builder.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		else if (element.getType() == Type.LIST_ITEM) {
			BulletSpan bulletSpan = new BulletSpan();
            builder.setSpan(bulletSpan, 0, builder.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		else if (element.getType() == Type.EMPHASIS) {
			StyleSpan italicSpan = new StyleSpan(Typeface.ITALIC);
            builder.setSpan(italicSpan, 0, builder.length(),
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		else if (element.getType() == Type.DOUBLE_EMPHASIS) {
			StyleSpan boldSpan = new StyleSpan(Typeface.BOLD);
            builder.setSpan(boldSpan, 0, builder.length(),
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		else if (element.getType() == Type.TRIPLE_EMPHASIS) {
			StyleSpan bolditalicSpan = new StyleSpan(Typeface.BOLD_ITALIC);
            builder.setSpan(bolditalicSpan, 0, builder.length(),
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		else if (element.getType() == Type.LINK) {
			URLSpan urlSpan = new URLSpan(element.getAttribute("link"));
            builder.setSpan(urlSpan, 0, builder.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		
		return builder;
	}
}