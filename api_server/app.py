from fastapi import FastAPI
from transformers import T5Tokenizer ,T5ForConditionalGeneration

base_path = './../data/results_3x_dataset'
trained_model = T5ForConditionalGeneration.from_pretrained(base_path + "/model")
tokenizer = T5Tokenizer.from_pretrained(base_path  +  '/tokenizer')

def infer(text):
    inputs = tokenizer.encode( text,return_tensors='pt',max_length=256, padding='max_length',truncation=True    )
    corrected_ids = trained_model.generate( inputs, max_length=256, num_beams=2, early_stopping=True )

    corrected_sentence = tokenizer.decode( corrected_ids[0],skip_special_tokens = True )
    return corrected_sentence


 
app = FastAPI()
 
@app.get("/")
def main(gesture: str):
    return {"pred": infer(gesture)}