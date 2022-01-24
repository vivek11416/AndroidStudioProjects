package com.example.animations;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

public class MainActivity extends AppCompatActivity {

    boolean isHomerShowing = true;
    public void fade(View view){

        ImageView homerImageView = (ImageView)findViewById(R.id.homerImageView);
        ImageView bartImageView = (ImageView)findViewById(R.id.bartImageView);


        if (isHomerShowing){
            isHomerShowing = false;
            homerImageView.animate().alpha(0).setDuration(2000);
            bartImageView.animate().alpha(1).setDuration(2000);
        }
        else{
            isHomerShowing = true;
            homerImageView.animate().alpha(1).setDuration(2000);
            bartImageView.animate().alpha(0).setDuration(2000);
        }

    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}