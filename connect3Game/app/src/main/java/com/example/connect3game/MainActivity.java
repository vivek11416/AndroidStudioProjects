package com.example.connect3game;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import androidx.gridlayout.widget.GridLayout;

import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    int currentPlayer=0;
    int[] availablePlaces = {2,2,2,2,2,2,2,2,2};
    int winningPositions[][]={{0,1,2},{3,4,5},{6,7,8},{0,3,6},{1,4,7},{2,5,8},{0,4,8},{2,4,6}};
    boolean gameContinueFlag = true;
    public void dropIt(View view){

        //yellow = 0 ;red = 1; emptySpace =2
        ImageView counter = (ImageView) view;

        if (availablePlaces[Integer.parseInt(counter.getTag().toString())-1] ==2 && gameContinueFlag) {
            counter.setTranslationY(-1500);
            if (currentPlayer == 0) {
                counter.setImageResource(R.drawable.yellow);
                availablePlaces[Integer.parseInt(counter.getTag().toString())-1]=0;
                currentPlayer = 1;
            } else {
                counter.setImageResource(R.drawable.red);
                availablePlaces[Integer.parseInt(counter.getTag().toString())-1]=1;
                currentPlayer = 0;
            }
            counter.animate().translationYBy(1500).rotation(100).setDuration(100);

            for (int[] winningPosition : winningPositions){

                if(availablePlaces[winningPosition[0]] == availablePlaces[winningPosition[1]] && availablePlaces[winningPosition[1]]==availablePlaces[winningPosition[2]] && availablePlaces[winningPosition[2]] !=2){
                    if (currentPlayer == 1){
                        Toast.makeText(this, "Yellow has won", Toast.LENGTH_SHORT).show();
                        gameContinueFlag= false;
                        Button btn = (Button)findViewById(R.id.resetButton);
                        btn.setVisibility(View.VISIBLE);
                    }
                    else{
                        Toast.makeText(this, "Red has won", Toast.LENGTH_SHORT).show();
                        gameContinueFlag= false;
                        Button btn = (Button)findViewById(R.id.resetButton);
                        btn.setVisibility(View.VISIBLE);
                    }
                }
            }
        }
    }

    public void playAgain(View view){
        Button btn = (Button)findViewById(R.id.resetButton);
        btn.setVisibility(View.INVISIBLE);
        GridLayout gridLayout = (GridLayout) findViewById(R.id.mainGridLayout);
        for(int i=0;i<gridLayout.getChildCount();i++){

            ImageView iv= (ImageView) gridLayout.getChildAt(i);
            iv.setImageDrawable(null);
        }

        for (int i=0;i<availablePlaces.length;i++) {
            availablePlaces[i] = 2;
        }
        gameContinueFlag = true;


    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btn = (Button)findViewById(R.id.resetButton);
        btn.setVisibility(View.INVISIBLE);
    }
}