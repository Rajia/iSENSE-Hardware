package edu.uml.cs.isense.carphysicsv2;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MessageDialogTemplate extends Activity {

	Button pos, neg;

	public void onCreate(Bundle b) {
		super.onCreate(b);
		setContentView(R.layout.message_template);

		setTitle(getIntent().getExtras().getString("title"));
		TextView messageBox = (TextView) findViewById(R.id.messageBox);
		messageBox.setText(getIntent().getExtras().getString("message"));

		pos = (Button) findViewById(R.id.positive);

		pos.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View arg0) {
				setResult(RESULT_OK);
				finish();

			}
		});
	}

	/**
	 * This function takes the following:
	 * 
	 * @param Context
	 *            mContext
	 * @param String
	 *            title
	 * @param String
	 *            message
	 * @param int reqCode and it creates a dialog with a single message.
	 */
	public static void createMessageDialog(Activity parent, Context mContext, String title,
			String message, int reqCode) {

		Intent i = new Intent(mContext, MessageDialogTemplate.class);
		i.putExtra("title", title);
		i.putExtra("message", message);

		parent.startActivityForResult(i, reqCode);

	}

}
